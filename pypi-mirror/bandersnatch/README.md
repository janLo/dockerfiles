Pypi mirror client
==================

This image contains a bandersnatch PEP 381 mirror.
See https://bitbucket.org/pypa/bandersnatch/

## How to use this Image

It runs the bandersnatch client with the mirror command.
You should run it as non-daemon container with a volume
mounted on `/srv/pypi`. See upstream project for full
documentation.


## Example

Assuming you have mounted your storage for the pypi-mirror
on the host at /mnt/pypi_data:

    docker run --rm -v /mnt/pypi_data:/srv/pypi janlo/pypi-mirror-bandersnatch:latest

