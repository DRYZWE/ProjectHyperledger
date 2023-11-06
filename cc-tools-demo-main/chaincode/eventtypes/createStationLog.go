package eventtypes

import "github.com/hyperledger-labs/cc-tools/events"

// CreateLibraryLog is a log to be emitted on the CCAPI when a library is created
var CreateStationLog = events.Event{
	Tag:         "createStationLog",
	Label:       "Create Station Log",
	Description: "Log of a Station creation",
	Type:        events.EventLog,                 // Event funciton is to log on the CCAPI
	BaseLog:     "New Station created",           // BaseLog is a base message to be logged
	Receivers:   []string{"$org2MSP", "$orgMSP"}, // Receivers are the MSPs that will receive the event
}
