### 📁 `neuron-replicator` – GitHub Repo Sync Utility

A lightweight shell-based utility to replicate code from one private GitHub repo to another.

---

### 📦 Folder Structure
```
neuron-replicator/
├── config.json              # Define source → destination repo pairs
├── run_all.sh              # Driver script to sync all repo pairs
└── scripts/
    └── replicator.sh       # Core logic for pulling & pushing repos
```

---

### ⚙️ Setup Requirements
- `git`
- `jq` (`sudo apt install jq` or `brew install jq`)
- Access to both source & destination repos via SSH or HTTPS

---

### 📄 `config.json` Format
```json
[
  {
    "source": "git@github.com:your-org/source-repo-1.git",
    "destination": "git@github.com:your-org/destination-repo-1.git"
  },
  {
    "source": "git@github.com:your-org/source-repo-2.git",
    "destination": "git@github.com:your-org/destination-repo-2.git"
  }
]
```

---

### 🚀 Usage
```bash
chmod +x run_all.sh
./run_all.sh
```

Each sync will ask for confirmation before pushing.

---

### 📌 Notes
- Syncs only the `main` branch.
- Uses `--force` push to destination.
- Temporary files are auto-cleaned after each run.

