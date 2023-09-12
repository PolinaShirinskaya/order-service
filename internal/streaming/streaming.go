package streaming

import (
	"encoding/json"
	"fmt"
	"log"
	"wb-L0-twst-task/internal/db"

	"github.com/nats-io/nats.go"
)

// Streaming представляет собой структуру для обработки данных, полученных через NATS Streaming.
type Streaming struct {
	dbObject *db.DB
}

// NewStream создает новое соединение с NATS Streaming и устанавливает обработчики подписки.
func NewStream(dbInstance *db.DB) (stream *nats.Conn) {
	stream, err := nats.Connect(nats.DefaultURL)
	if err != nil {
		log.Fatalf("can't connect to NATS: %v", err)
	}

	NewSubscribe(dbInstance, stream)

	return stream
}

// NewSubscribe устанавливает подписку на канал "intros" в NATS Streaming и связывает обработчик.
func NewSubscribe(dbInstance *db.DB, stream *nats.Conn) (*nats.Subscription, error) {
	subscription, err := stream.Subscribe("intros", func(msg *nats.Msg) {
		SubscribeReceiver(dbInstance, msg)
	})

	if err != nil {
		return nil, err
	}
	return subscription, nil
}

// SubscribeReceiver обрабатывает сообщение, полученное из NATS Streaming, и добавляет информацию о заказе в базу данных.
func SubscribeReceiver(dbInstance *db.DB, msg *nats.Msg) {
	var orderData db.Order

	err := json.Unmarshal([]byte(msg.Data), &orderData)

	if err != nil {
		fmt.Printf("Error unmarshaling JSON: %v\n", err)
		return
	}

	dbInstance.AddOrderInfo(orderData)

	fmt.Println(orderData.OrderUID)
}
