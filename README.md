# find-dapla-deploy

Roswell/Consfigurator deploy of the service at `find.dapla.net`.

## Repository Layout

```
find-dapla-deploy.ros   Thin Roswell entry point
find-dapla-deploy.asd   Umbrella ASDF system definition
qlfile         Qlot dependency pins
src/deploy.lisp  Consfigurator properties and DEFHOST
src/docs.lisp    40ants-doc sections
t/e2e.lisp       Post-deploy FiveAM smoke tests
docs.ros         Documentation generator
Makefile         build / test / doc / dist / clean
```

## Installation

```sh
ros install qlot
qlot install
./find-dapla-deploy.ros
```

## Runbook

```sh
machinectl shell find@ -- systemctl --user status
machinectl shell find@ -- journalctl --user -f
machinectl shell find@ -- podman auto-update
```

Redeploy by re-running `./find-dapla-deploy.ros`. Idempotent.

## Playbook

### ZFS replication (rsync.net)

```sh
zfs snapshot storage/containers/find@$(date +%Y%m%d)
zfs send -w storage/containers/find@$(date +%Y%m%d) | \
  ssh user@rsync.net zfs receive backup/find
```

Key files under `/etc/zfs-keys/` must be backed up separately.

## Decommission

```sh
machinectl shell find@ -- systemctl --user stop find
machinectl shell find@ -- systemctl --user disable find
zfs destroy -r storage/users/find
zfs destroy -r storage/containers/find
```

## License

BSD 3-Clause. See [LICENSE](LICENSE).
