#!/bin/bash

echo "--- 安裝 K3s ---"

# 1. 使用官方 K3s 安裝腳本進行安裝
# INSTALL_K3S_EXEC="--disable traefik" 可以禁用內建的 Ingress Controller (可選)
curl -sfL https://get.k3s.io | sh -

# 2. 檢查 K3s 服務狀態
echo "等待 K3s 啟動..."
sudo k3s check-config # 檢查配置
sleep 15 # 等待服務啟動

# 3. 配置 kubectl
# 將 K3s 的 Kubeconfig 檔案複製到標準位置，並設定權限
mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 4. 驗證 K8s 叢集狀態
echo "--- K8s 叢集狀態 ---"
kubectl cluster-info
kubectl get nodes

echo "K3s 安裝與配置完成！"