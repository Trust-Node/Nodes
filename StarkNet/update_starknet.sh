#!/bin/bash

echo "-----------------------------------------------------------------------------"
echo "Начинаем обновление репрозитория "
echo "-----------------------------------------------------------------------------"
cd ~/pathfinder
git fetch &>/dev/null
git checkout v0.2.3-alpha &>/dev/null
echo "Репозиторий успешно обновлен, начинаем сборку"
echo "-----------------------------------------------------------------------------"
cargo build --release --bin pathfinder &>/dev/null
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
cd py
source .venv/bin/activate &>/dev/null
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip &>/dev/null
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt &>/dev/null
sleep 2
echo "Сборка завершена"
echo "-----------------------------------------------------------------------------"
systemctl restart starknetd
echo "Версия: " $(pathfinder -V)
echo "-----------------------------------------------------------------------------"
