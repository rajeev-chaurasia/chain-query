package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
	// This is the public RPC endpoint for Arbitrum One.
	rpcURL := "https://arb1.arbitrum.io/rpc"

	// Connect to the node.
	client, err := ethclient.Dial(rpcURL)
	if err != nil {
		log.Fatalf("Failed to connect to the Arbitrum node: %v", err)
	}

	fmt.Println("Success! Connected to the Arbitrum node.")

	// Let's test it by fetching the latest block number.
	// 'nil' means "the latest block".
	header, err := client.HeaderByNumber(context.Background(), nil)
	if err != nil {
		log.Fatalf("Failed to get latest block header: %v", err)
	}

	fmt.Printf("Latest Block Number: %s\n", header.Number.String())
}