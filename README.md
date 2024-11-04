## LINUX-ENVIRONMENT
Inspired by the great FloopCZ (https://github.com/FloopCZ/linux-environment)

## Deployment
```bash
git clone https://github.com/honzov/linux-environment.git
cd linux-environment
./deploy.sh --install
```
Do not forget to change your .gitconfit.

## Run linux-env in docker
```bash
git clone https://github.com/honzov/linux-environment.git
cd linux-environment
docker build -t honzov/linux-env:latest -f dockerfiles/archlinux .
# or docker pull honzov/linux-env:latest
docker run --rm -d -p 2222:22 honzov/linux-env:latest
ssh somebody@localhost -p 2222 # password: pass
```

## Optional steps
C++ development:
```
clangd cmake
```

New ssh key generation and provisioning:
```
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-copy-id username@server_address
```
