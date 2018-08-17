// Copyright 2016 The go-xone Authors
// This file is part of the go-xone library.
//
// The go-xone library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-xone library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-xone library. If not, see <http://www.gnu.org/licenses/>.

// Contains all the wrappers from the params package.

package gxone

import (
	"encoding/json"

	"github.com/xonechain/go-xone/core"
	"github.com/xonechain/go-xone/p2p/discv5"
	"github.com/xonechain/go-xone/params"
)

// MainnetGenesis returns the JSON spec to use for the main Xonechain network. It
// is actually empty since that defaults to the hard coded binary genesis block.
func MainnetGenesis() string {
	return ""
}

// TestnetGenesis returns the JSON spec to use for the Xonechain test network.
func TestnetGenesis() string {
	enc, err := json.Marshal(core.DefaultTestnetGenesisBlock())
	if err != nil {
		panic(err)
	}
	return string(enc)
}

// RinkebyGenesis returns the JSON spec to use for the Rinkeby test network
func RinkebyGenesis() string {
	enc, err := json.Marshal(core.DefaultRinkebyGenesisBlock())
	if err != nil {
		panic(err)
	}
	return string(enc)
}

// FoundationXoneboots returns the enode URLs of the P2P bootstrap nodes operated
// by the foundation running the V5 discovery protocol.
func FoundationXoneboots() *Enodes {
	nodes := &Enodes{nodes: make([]*discv5.Node, len(params.DiscoveryV5Xoneboots))}
	for i, url := range params.DiscoveryV5Xoneboots {
		nodes.nodes[i] = discv5.MustParseNode(url)
	}
	return nodes
}
