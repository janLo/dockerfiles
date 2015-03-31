Pypi mirror nginx docker image
==============================

This is an docker image of nginx with a simple configuration
to serve a pypi mirror index. You can use the 
janlo/pypi-mirror-bandersnatch image to fetch the data this
image serves.

## Configuration

Configuration is done by environment variables.

### `PYPI_SERVER_NAME`

Set the nginx servername.


## Example

Suppose you have synced the pypi data to `/mnt/pypi_data`:

    docker run -d -p 127.0.0.1:8080:80 \
    	-v /mnt/pypi_data/web:/web \
    	-e PYPI_SERVER_NAME=pypi-mirror \
    	janlo/pypi-mirror-nginx

Then you have alocal pypi mirror at `http://127.0.0.1:8080`.
You can use it either by configuring pip within the `~/.pip/pip.conf`:

    [global]
    index-url = http://pypi.domain.local/simple

Or by the commandline option `--index-url`:

    pip install --index-url=http://127.0.0.1:8080/simple somepackage
