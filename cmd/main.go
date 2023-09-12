package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"net/http"

	"wb-L0-twst-task/cmd/config"
	"wb-L0-twst-task/internal/db"
	"wb-L0-twst-task/internal/streaming"

	"github.com/gorilla/mux"
)

func main() {
	// Выполняем настройку конфигурации приложения
	config.ConfigSetup()

	// Создаем экземпляр базы данных
	dbInstance, error := db.NewDB()
	if error == nil {
		fmt.Println("База данных подключена!")
	}

	// Создаем экземпляр кэша
	csh := db.NewCache(dbInstance)

	// Инициализируем потоковую обработку данных
	streaming.NewStream(dbInstance)

	// Создаем маршрутизатор для обработки HTTP-запросов
	r := mux.NewRouter()

	// Определяем обработчики для API-маршрутов
	r.HandleFunc("/api/getOrderInfo", GetOrderInfoByOrderUid).Methods("GET")
	r.HandleFunc("/api/getOrderInfo/{orderUID}", func(w http.ResponseWriter, r *http.Request) {
		GetOrderInfo(w, r, csh)
	}).Methods("GET")

	// Настроим обработку корневого URL
	http.Handle("/", r)

	fmt.Println("Сервер работает на порту :8080...")
	http.ListenAndServe(":8080", nil)
}

// GetOrderInfoByOrderUid обрабатывает запрос для получения информации о заказе по его уникальному идентификатору (OrderUID).
func GetOrderInfoByOrderUid(w http.ResponseWriter, r *http.Request) {
	// Парсим HTML-шаблон
	tmpl, err := template.ParseFiles("template/template.html")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// Выполняем шаблонизацию и отправляем HTML-страницу клиенту
	if err := tmpl.Execute(w, nil); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

// GetOrderInfo обрабатывает запрос для получения информации о заказе по его уникальному идентификатору (OrderUID).
func GetOrderInfo(w http.ResponseWriter, r *http.Request, dbInstance *db.Cache) {
	// Устанавливаем заголовок Content-Type для ответа
	w.Header().Set("Content-Type", "application/json")

	// Извлекаем параметры из URL
	vars := mux.Vars(r)
	orderUID := vars["orderUID"]

	// Получаем информацию о заказе из кэша
	orderFetch, err := dbInstance.DBInst.GetOrderByUid(orderUID)

	if err != nil {
		// В случае ошибки возвращаем статус "500 Internal Server Error"
		http.Error(w, "Не удалось получить информацию о заказе из базы данных", http.StatusInternalServerError)
		return
	}

	// Создаем структуру Order для ответа
	order := db.Order{
		OrderUID:          orderFetch.OrderUID,
		TrackNumber:       orderFetch.TrackNumber,
		Entry:             orderFetch.Entry,
		Delivery:          orderFetch.Delivery,
		Payment:           orderFetch.Payment,
		Items:             orderFetch.Items,
		Locale:            orderFetch.Locale,
		InternalSignature: orderFetch.InternalSignature,
		CustomerID:        orderFetch.CustomerID,
		DeliveryService:   orderFetch.DeliveryService,
		Shardkey:          orderFetch.Shardkey,
		SMID:              orderFetch.SMID,
		DateCreated:       orderFetch.DateCreated,
		OofShard:          orderFetch.OofShard,
	}

	// Кодируем структуру в JSON и отправляем клиенту
	json.NewEncoder(w).Encode(order)
}
