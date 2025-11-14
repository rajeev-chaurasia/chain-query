# 🚀 ChainQuery - L2 Token Tracker

ChainQuery is a high-performance indexing service that provides developers with clean, real-time API access to all ERC-20 (token) and ERC-721 (NFT) transfer data on the Arbitrum One mainnet.

This service saves developers from the pain of running a full node or building complex indexers.

---

### ✨ Features (MVP)

* **REST API:** Get historical token and NFT transfer data.
* **WebSocket API:** Subscribe to live, real-time transfers.
* **Single Focus:** Optimized for one thing: tracking transfers on Arbitrum.

---

### 🛠️ Tech Stack

* **Backend:** Golang
* **Database:** PostgreSQL
* **Deployment:** Docker
* **Blockchain:** Geth, `go-ethereum`

---

### 🔌 API Endpoints (MVP)

#### REST
* `GET /v1/address/{address}/erc20/transfers`
* `GET /v1/address/{address}/nft/transfers`
* `GET /v1/token/{contractAddress}/transfers`

#### WebSocket
* `wss:///v1/ws`
    * **Subscribe:** `{"method": "subscribe", "type": "erc20_transfers", "address": "0x..."}`

---

### 🏁 Getting Started

See our [**Developer Onboarding Guide**](CONTRIBUTING.md) for instructions on how to run this project locally.