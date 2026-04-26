#!/usr/bin/env bash
set -euo pipefail

SSH_KEY_PATH="${1:-}"
SSH_USER="${2:-ubuntu}"

if [[ -z "$SSH_KEY_PATH" ]]; then
  echo "Usage: $0 <ssh_private_key_path> [ssh_user]"
  echo "Example: $0 ~/.ssh/my-key.pem ubuntu"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TF_DIR="${ROOT_DIR}/terraform"
HOSTS_FILE="${SCRIPT_DIR}/hosts.yml"

if [[ ! -d "${TF_DIR}" ]]; then
  echo "Terraform directory not found: ${TF_DIR}"
  exit 1
fi

PUBLIC_IP="$(cd "${TF_DIR}" && terraform output -raw ec2_public_ip)"

cat > "${HOSTS_FILE}" <<EOF
all:
  children:
    master:
      hosts:
        ${PUBLIC_IP}:
          ansible_user: ${SSH_USER}
          ansible_ssh_private_key_file: ${SSH_KEY_PATH}
    # workers:
    #   hosts:
    #     # Add worker node IPs here
EOF

echo "Inventory updated: ${HOSTS_FILE}"
echo "Master node: ${PUBLIC_IP}"