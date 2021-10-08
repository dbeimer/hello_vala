# project name and programming language
project('com.github.dbeimer.hello_vala', 'vala', 'c')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src' / 'Application.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)

# Install our .desktop file so the Applications Menu will see it
install_data(
    'data' / 'hello_vala.desktop',
    install_dir: get_option('datadir') / 'applications',
    rename: meson.project_name() + '.desktop'
)

# Install our .appdata.xml file so AppCenter will see it
install_data(
    'data' / 'hello_vala.appdata.xml',
    install_dir: get_option('datadir') / 'metainfo',
    rename: meson.project_name() + '.appdata.xml'
)
