import logging
import os
import subprocess
import sys

from typing import List


def execute_command(command: List[str]) -> str:
    output = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    stdout, stderr = output.communicate()
    if stderr is not None:
        logging.error(f'Error in performing command: {stderr}')
        sys.exit(1)

    return stdout.decode('utf-8')


def read_file_content(filename: str) -> List[str]:
    content_array = []
    with open(filename) as f:
        for line in f:
            content_array.append(line[:-1])
    return content_array


def main():
    # get list of all current favorite apps
    stdout: str = execute_command(['/usr/bin/gsettings', 'get', 'org.gnome.shell', 'favorite-apps'])
    current_favorite_apps: List[str] = stdout[1:][:-2].replace("'", "").replace(" ", "").split(',')

    current_dir = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
    # my favorite apps
    favorite_apps: List[str] = read_file_content(f'{current_dir}/favorite_apps.txt')
    # apps that need to be removed from the favorite apps
    to_remove_apps: List[str] = read_file_content(f'{current_dir}/to_remove_apps.txt')

    favorite_apps += current_favorite_apps
    for item in favorite_apps:
        if item in to_remove_apps:
            favorite_apps.remove(item)

    # Remove duplicate entries
    favorite_apps = list(set(favorite_apps))

    message: str = execute_command([' dconf', 'write', '/org/gnome/shell/favorite-apps', str(favorite_apps)])
    logging.info(message)

if __name__ == "__main__":
    main()
