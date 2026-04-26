#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <ssh_private_key_path> [ssh_user]"
  exit 1
fi

SSH_KEY_PATH="$1"
SSH_USER="${2:-ubuntu}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TF_DIR="${ROOT_DIR}/terraform"
HOSTS_FILE="${SCRIPT_DIR}/hosts.ini"

if [[ ! -d "${TF_DIR}" ]]; then
  echo "Terraform directory not found: ${TF_DIR}"
  exit 1
fi

PUBLIC_IP="$(cd "${TF_DIR}" && terraform output -raw ec2_public_ip)"

cat > "${HOSTS_FILE}" <<EOF
[k8s]
${PUBLIC_IP} ansible_user=${SSH_USER} ansible_ssh_private_key_file=${SSH_KEY_PATH} ansible_python_interpreter=/usr/bin/python3
EOF

echo "Inventory updated: ${HOSTS_FILE}"
echo "Target host: ${PUBLIC_IP}"
