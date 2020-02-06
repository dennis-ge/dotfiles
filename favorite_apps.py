import subprocess
import sys

to_delete = [
    # 'ubuntu-amazon-default.desktop',
    # 'org.gnome.Software.desktop',
    # 'libreoffice-writer.desktop',
    'rhythmbox.desktop'
]


def main():
    out = subprocess.Popen(['/usr/bin/gsettings', 'get', 'org.gnome.shell', 'favorite-apps'],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT)
    stdout, stderr = out.communicate()
    stdout = stdout.decode('utf-8')
    if stderr is not None:
        print('ERROR')
        print(stderr)
        sys.exit(1)

    stdout_arr = stdout[1:][:-2].replace("'", "").replace(" ", "").split(',')

    fav_apps = [x for x in stdout_arr]
    for item in stdout_arr:
        if item in to_delete:
            fav_apps.remove(item)

    with open('favorite_apps.txt') as f:
        line = f.readline()

        while line:
            fav_apps.append(line[:-1])
            line = f.readline()
    final = str(fav_apps)  # .encode()

    print(final)
    sys.exit(final)


if __name__ == "__main__":

    main()
