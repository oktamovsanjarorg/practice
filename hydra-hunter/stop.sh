#!/usr/bin/env bash
echo "🛑 Gidrani favqulodda to'xtatish..."
pkill -9 -f "hydra_master.py" 2>/dev/null || true
pkill -9 -f "hydra_head.py" 2>/dev/null || true
echo "Barcha Gidra jarayonlari majburiy to'xtatildi."
