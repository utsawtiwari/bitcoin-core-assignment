# 🪙 Bitcoin Regtest Network with Docker

A minimal Bitcoin regtest environment running two nodes (`btc1`, `btc2`) using Docker and Bitcoin Core v25.0. It mines blocks, sends transactions, and automates linting and transaction execution via GitHub Actions.

---

## 📁 Project Structure

```
bitcoin-regtest-full/
├── Dockerfile                 # Custom image with Bitcoin Core v25.0
├── docker-compose.yml        # Defines btc1 and btc2 services
├── scripts/
│   └── init-transaction.sh   # Script to mine & send transactions
└── .github/
    └── workflows/
        ├── ci.yaml           # Lints .sh, Dockerfile
        └── cd.yaml           # Runs transaction flow manually
```

---

## 🚀 Getting Started Locally

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/bitcoin-regtest-full.git
cd bitcoin-regtest-full
```

### 2. Build and start the network

```bash
docker compose up --build -d
```

### 3. Run the transaction script

```bash
chmod +x scripts/init-transaction.sh
./scripts/init-transaction.sh
```

### 4. View logs or shut down

```bash
docker logs btc1
docker logs btc2

docker compose down -v
```

---

## ⚙️ GitHub Actions

### ✅ CI Pipeline (`ci.yaml`)

- **Triggers on:** Push/merge to `main`
- **Runs on changes to:** `.sh`, `Dockerfile`, or `docker-compose.yml`
- **Steps:**
  - Shell linting via `shellcheck`
  - Skips CD pipeline (`cd.yaml`)

### 🚀 CD Pipeline (`cd.yaml`)

- **Trigger:** Manual via GitHub Actions UI
- **Steps:**
  - Starts Bitcoin nodes
  - Runs the `init-transaction.sh` script
  - Sends a transaction
  - Logs final balances
  - Stops and removes containers

---

## 🧪 Example Output

```
btc1 is ready.
btc2 is ready.
💸 Sending 10 BTC from btc1 to btc2...
✅ Transaction ID: 726be1...
🎉 Final Balances:
btc1: 39.999 BTC
btc2: 10.000 BTC
```

---

## ✅ Best Practices Followed

- Descriptive commit history
- Shell and Dockerfile linting in CI
- CD triggers clean, repeatable transaction flow
- No log files uploaded; everything is printed in CI/CD logs
