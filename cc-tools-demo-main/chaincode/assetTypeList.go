package main

import (
	"github.com/hyperledger-labs/cc-tools-demo/chaincode/assettypes"
	"github.com/hyperledger-labs/cc-tools/assets"
)

var assetTypeList = []assets.AssetType{
	assettypes.Person,
	assettypes.Bike,
	assettypes.Station,
	assettypes.Secret,
}
