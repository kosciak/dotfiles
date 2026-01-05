#!/usr/bin/env python

import argparse
import logging

import yaml


log = logging.getLogger()


PACKAGES_FN = 'packages.yaml'

DNF_PACKAGES = 'DNF'
COPR_PACKAGES = 'COPR'
DOWNLOADS_PACKAGES = 'Downloads'
FLATPAK_PACKAGES = 'Flatpak'
FLATHUB_REMOTE = 'flathub'


def get_packages_data(packages_fn=None):
    packages_fn = packages_fn or PACKAGES_FN
    with open(packages_fn, 'r') as f:
        data = yaml.safe_load(f)
        return data


def show_dnf(packages_fn=None):
    packages_data = get_packages_data(packages_fn)
    dnf_packages = packages_data.get(DNF_PACKAGES) or {}
    print('##')
    print('# DNF packages')
    print('##')
    for group_name, packages in dnf_packages.items():
        if not packages:
            continue
        print(f'# {group_name}')
        print(f'sudo dnf install {' '.join(packages)}')


def show_copr(packages_fn=None):
    packages_data = get_packages_data(packages_fn)
    copr_packages = packages_data.get(COPR_PACKAGES) or []
    print('##')
    print('# COPR packages')
    print('##')
    for package in copr_packages:
        print(f'sudo dnf copr enable {package['repo']}')
        print(f'sudo dnf install {package['package']}')


def show_flatpak(packages_fn=None):
    packages_data = get_packages_data(packages_fn)
    flatpak_packages = packages_data.get(FLATPAK_PACKAGES) or []
    print('##')
    print('# Flatpak packages')
    print('##')
    for package in flatpak_packages:
        remote = package.get('remote', FLATHUB_REMOTE)
        print(f'# {package['name']}')
        print(f'sudo flatpak install {remote} {package['id']}')


def show_downloads(packages_fn=None):
    packages_data = get_packages_data(packages_fn)
    downloads_packages = packages_data.get(DOWNLOADS_PACKAGES) or []
    print('##')
    print('# Manual installation')
    print('##')
    for package in downloads_packages:
        print(f'# {package['name']}')
        print(f'# {package['url']}')


def show_manual(packages_fn=None):
    show_downloads(packages_fn)


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="[%(asctime)s] %(levelname)s: %(message)s",
    )

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dnf",
        action='store_true', default=False,
        help="system DNF packages"
    )
    parser.add_argument(
        "--copr",
        action='store_true', default=False,
        help="packages from COPR repos"
    )
    parser.add_argument(
        "--flatpak",
        action='store_true', default=False,
        help="Flatpak installation"
    )
    parser.add_argument(
        "--manual",
        action='store_true', default=False,
        help="Manual installation"
    )
    parser.add_argument(
        "--all",
        action='store_true', default=False,
        help="All packages"
    )
    args = parser.parse_args()

    if args.dnf or args.all:
        show_dnf()

    if args.copr or args.all:
        show_copr()

    if args.flatpak or args.all:
        show_flatpak()

    if args.manual or args.all:
        show_manual()

