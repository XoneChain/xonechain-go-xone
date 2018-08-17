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

package ethclient

import "github.com/xonechain/go-xone"

// Verify that Client implements the xonechain interfaces.
var (
	_ = xonechain.ChainReader(&Client{})
	_ = xonechain.TransactionReader(&Client{})
	_ = xonechain.ChainStateReader(&Client{})
	_ = xonechain.ChainSyncReader(&Client{})
	_ = xonechain.ContractCaller(&Client{})
	_ = xonechain.GasEstimator(&Client{})
	_ = xonechain.GasPricer(&Client{})
	_ = xonechain.LogFilterer(&Client{})
	_ = xonechain.PendingStateReader(&Client{})
	// _ = xonechain.PendingStateEventer(&Client{})
	_ = xonechain.PendingContractCaller(&Client{})
)
