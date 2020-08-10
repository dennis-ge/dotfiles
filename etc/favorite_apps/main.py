import subprocess
import sys
import os

to_delete = [
    'ubuntu-amazon-default.desktop',
    'org.gnome.Software.desktop',
    'libreoffice-writer.desktop',
    'rhythmbox.desktop'
]


def main():
    output = subprocess.Popen(['/usr/bin/gsettings', 'get', 'org.gnome.shell', 'favorite-apps'],
                              stdout=subprocess.PIPE,
                              stderr=subprocess.STDOUT)
    stdout, stderr = output.communicate()
    if stderr is not None:
        print('ERROR')
        print(stderr)
        sys.exit(1)

    stdout = stdout.decode('utf-8')
    stdout_list = stdout[1:][:-2].replace("'", "").replace(" ", "").split(',')

    favorite_apps_list = [x for x in stdout_list]
    for item in stdout_list:
        if item in to_delete:
            favorite_apps_list.remove(item)

    current_dir = os.path.realpath(os.path.join(
        os.getcwd(), os.path.dirname(__file__)))
    with open(current_dir+'/favorite_apps.txt') as f:
        line = f.readline()

        while line:
            favorite_apps_list.append(line[:-1])
            line = f.readline()

    # Remove duplciate entries
    favorite_apps_list = list(set(favorite_apps_list))

    # Return new favorite apps
    sys.exit(str(favorite_apps_list))


if __name__ == "__main__":
    main()
