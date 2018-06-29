import click
import logging
import yaml

import enos_sharelatex.tasks as t
from enos_sharelatex.constants import CONF

logging.basicConfig(level=logging.DEBUG)


@click.group()
def cli():
    pass


def load_config(file_path):
    """
    Read configuration from a file in YAML format.
    :param file_path: Path of the configuration file.
    :return:
    """
    with open(file_path) as f:
        configuration = yaml.safe_load(f)
    return configuration


@cli.command(help="Claim resources on Grid'5000 (frontend).")
@click.option("--force",
              is_flag=True,
              help="force redeployment")
@click.option("--conf",
              default=CONF,
              help="alternative configuration file")
@click.option("--env",
              help="alternative environment directory")
def g5k(force, conf, env):
    config = load_config(conf)
    t.deploy('g5k', config, force, env=env)


@cli.command(help="Claim resources on vagrant (localhost).")
@click.option("--force",
              is_flag=True,
              help="force redeployment")
@click.option("--conf",
              default=CONF,
              help="alternative configuration file")
@click.option("--env",
              help="alternative environment directory")
def vagrant(force, conf, env):
    config = load_config(conf)
    t.deploy('vagrant', config, force, env=env)


@cli.command(help="Generate the Ansible inventory [after g5k or vagrant].")
@click.option("--env",
              help="alternative environment directory")
def inventory(env):
    t.inventory(env=env)


@cli.command(help="Configure available resources [after deploy, inventory or\
             destroy].")
@click.option("--env",
              help="alternative environment directory")
def prepare(env):
    t.prepare(env=env)


@cli.command(help="Backup the deployed environment")
@click.option("--env",
              help="alternative environment directory")
def backup(env):
    t.backup(env=env)


@cli.command(help="Destroy the deployed environment")
@click.option("--env",
              help="alternative environment directory")
def destroy(env):
    t.destroy(env=env)

@cli.command(help="Bring down the deployed resources")
@click.argument("provider")
@click.option("--conf",
              default=CONF,
              help="alternative configuration file")
def down(provider, conf):
    config = load_config(conf)
    t.down(provider, config)


@cli.command(help="Claim resources from a PROVIDER and configure them.")
@click.argument("provider")
@click.option("--force",
              is_flag=True,
              help="force redeployment")
@click.option("--conf",
              default=CONF,
              help="alternative configuration file")
@click.option("--env",
              help="alternative environment directory")
def deploy(provider, force, conf, env):
    config = load_config(conf)
    t.deploy(provider, config, force, env=env)
    t.inventory()
    t.prepare(env=env)
