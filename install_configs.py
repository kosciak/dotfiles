#!/usr/bin/env python

import argparse
from dataclasses import dataclass
import datetime
from enum import Enum, auto
import json
import logging
import os
from pathlib import Path
import shutil


log = logging.getLogger()


class Mode(Enum):
    COPY=auto()
    MOVE=auto()
    SYMLINK=auto()


@dataclass
class Config:
    name: str
    reference: str
    comments: str
    tags: set
    copy_files: list
    symlink_files: list

    @staticmethod
    def parse(name, data):
        return Config(
            name=name,
            tags=set(data.get('tags') or []),
            reference=data.get('reference') or '',
            comments=data.get('comments') or '',
            copy_files=data.get('copy') or [],
            symlink_files=data.get('symlink') or [],
        )


@dataclass
class Command:
    mode: Mode
    src: Path
    dst: Path

    def run(self):
        if self.mode == Mode.COPY:
            if self.src.is_dir():
                shutil.copytree(self.src, self.dst)
            else:
                shutil.copy2(self.src, self.dst)
        if self.mode == Mode.MOVE:
            shutil.move(self.src, self.dst)
        if self.mode == Mode.SYMLINK:
            os.symlink(self.src, self.dst)


def load_configs():
    with open('configs.json', 'r') as f:
        configs = json.load(f)
    return [
        Config.parse(name, data) for name, data in configs.items()
    ]


def get_names(configs):
    names = set(
        config.name for config in configs
    )
    return names


def get_tags(configs):
    tags = set()
    for config in configs:
        tags.update(config.tags)
    return tags


def filter_configs(configs, names, tags):
    selected = []
    names = set(names or [])
    tags = set(tags or [])

    for config in configs:
        if config.name in names:
            selected.append(config)
            continue
        for tag in config.tags:
            if tag in tags:
                selected.append(config)

    return selected


def check_src_file(src):
    if not src.exists():
        log.error("Missing source: %s", src)
        raise FileNotFoundError(src)
    return; yield


def check_dst_file(src, dst, mode):
    if dst.exists():
        if mode == Mode.SYMLINK and dst.is_symlink() and dst.readlink() == src:
            log.info('%8s: %s -> %s', 'OK', dst, src)
            return

        # TODO: Check if src == dst in mode == Mode.COPY (md5 sum? filecmp module?)

        log.warning('Destination exists: %s', dst)
        now = datetime.datetime.now()
        target = Path(
            dst.parents[0],
            f"{dst.name}.copy-{now.strftime('%Y%m%d')}",
        )
        yield Command(Mode.MOVE, dst, target)

    yield Command(mode, src, dst)


def process_file(path, mode):
    path = Path(path)
    cwd = Path.cwd()
    home = Path.home()
    if path.is_absolute():
        src = cwd.joinpath(*path.parts[1:])
        dst = path
    else:
        src = cwd.joinpath(path)
        dst = home.joinpath(path)

    yield from check_src_file(src)
    yield from check_dst_file(src, dst, mode)


def process_config(config, dry_run=False):
    log.info('Config  : %s', config.name)
    commands = []
    for path in config.copy_files:
        commands.extend(process_file(
            path, mode=Mode.COPY,
        ))
    for path in config.symlink_files:
        commands.extend(process_file(
            path, mode=Mode.SYMLINK,
        ))

    for command in commands:
        log.info('%8s: %s -> %s',
                 command.mode.name, command.src, command.dst)
        if not dry_run:
            try:
                command.run()
            except Exception as e:
                log.exception('Command failed: %s', e)
                raise e


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="[%(asctime)s] %(levelname)s: %(message)s",
    )

    configs = load_configs()

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dry_run",
        action="store_true",
        help="Dry run without making any changes",
    )
    parser.add_argument(
        "--config",
        dest="names", action="extend", nargs="*",
        choices=sorted(get_names(configs)),
        help="Select configs with given name(s)",
    )
    parser.add_argument(
        "--tag",
        dest="tags", action="extend", nargs="*",
        choices=sorted(get_tags(configs)),
        help="Select configs with given tag(s)",
    )
    # TODO: --list
    args = parser.parse_args()

    selected = filter_configs(configs, names=args.names, tags=args.tags)
    for config in selected:
        process_config(config, dry_run=args.dry_run)

