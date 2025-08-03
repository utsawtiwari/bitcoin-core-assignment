# Bitcoin Regtest Full Node with Transaction Script

This project sets up a private Bitcoin regtest network using Docker and automates:
- Node startup and connectivity
- Wallet creation and mining
- At least five transactions between two nodes
- GitHub Actions workflows for CI and CD

---

## 🧰 Project Structure

```
.
├── Dockerfile                  # Builds the Bitcoin Core environment
├── docker-compose.yml         # Defines two Bitcoin nodes in regtest mode
├── scripts/
│   └── init-transaction.sh    # Automates mining, transaction and logs results
└── .github/
    └── workflows/
        ├── ci.yaml            # Lint Dockerfile and shell scripts
        └── cd.yaml            # Run full system and print logs
```

---

## 🚀 Quick Start

```bash
git clone https://github.com/yourusername/bitcoin-regtest-full.git
cd bitcoin-regtest-full
docker compose up -d
./scripts/init-transaction.sh
```

---

## ✅ Sample Output

```bash
⏳ Waiting for btc1...
✅ btc1 is ready.
⏳ Waiting for btc2...
✅ btc2 is ready.
Wallet created successfully.
btc1 address: bcrt1qxyz...
btc2 address: bcrt1qabc...
Mining 101 blocks to fund btc1...
Generated blocks: [000000...abc, 000000...def, ...]
Sending 0.1 BTC from btc1 to btc2...
Transaction ID: a1b2c3d4e5f6...
Mining a block to confirm transaction...
✅ Transaction confirmed.

btc1 balance: 49.89990000
btc2 balance: 0.10000000

📄 Transactions log saved to: scripts/transactions.log
```

---

## 🧪 GitHub Actions Workflows

### `ci.yaml`
- Trigger: On changes to `.sh`, `Dockerfile`, or `docker-compose.yml` and merge to `main`
- Validates:
  - Shell scripts via ShellCheck
  - Dockerfile linting

### `cd.yaml`
- Trigger: Manual dispatch only
- Steps:
  - Spins up regtest network
  - Runs `init-transaction.sh`
  - Displays logs in GitHub Actions
  - Shuts down the environment

---

## 📄 Logs

All transaction hashes and balances are recorded in:

```
scripts/transactions.log
```

---
