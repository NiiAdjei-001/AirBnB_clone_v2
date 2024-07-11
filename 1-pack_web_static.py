#!/usr/bin/python3
'''Fab Module: Compress webstatic files
'''


from datetime import datetime
from fabric.api import *
from os import path


@task
def do_pack():
    today = datetime.now()
    source_url = 'web_static'
    archive_url = "versions/web_static_{}{}{}{}{}{}.tgz".format(
        today.strftime('%Y'),
        today.strftime('%m'),
        today.strftime('%d'),
        today.strftime('%H'),
        today.strftime('%M'),
        today.strftime('%S')
    )

    cmd = "tar -cvzf {} {}".format(archive_url, source_url)
    if not path.isdir('versions'):
        local('mkdir -p versions')
    local(cmd)

    if (path.isfile(archive_url)):
        return(archive_url)
    return(None)
