# API для статистики по погоде

### Источник данных: [`accuweather`](https://developer.accuweather.com/apis)
###### Ruby: `3.1.2` Rails: `7.0.4` 

### Эндпоинты:

- /api/v1/weather/current - Текущая температура
- /api/v1/weather/historical - Почасовая температура за последние 24 часа 
- /api/v1/weather/historical/max - Максимальная температура за 24 часа
- /api/v1/weather/historical/min - Минимальная температура за 24 часа
- /api/v1/weather/historical/avg - Средняя температура за 24 часа
- /api/v1/weather/by_time - ближайшая к переданному "timestamp" температура
- /api/v1/health - Статус бэкенда

### Дополнительные сведения:
- Нагрузка на любой эндпоинт: 5 RPS;
- Для получения "api-key" зарегистрируйтесь на сайте [`developer.accuweather.com`](https://developer.accuweather.com/)
  и следуйте дальнейшим указаниям;
- База данных обновляется в режиме перезаписи каждые 3 часа при запущенном сервере;
- Ежеминутно осуществляется проверка на присутствие в базе данных необходимой информации;
- Команда для просмотра маршрутов API: `$ rake grape:routes`;
- Для выполнения запросов и тестирования api-приложения удобно использовать такое
  сервисное решение, как [`Postman`](https://www.postman.com/)


### Установка:
1. Клонирование репозитория:
```
$ git clone git@github.com:ProfessorNemo/weather_api.git
```

2. Установка зависимостей:
```
$ bundle
```

3. Чтобы задать географический объект (город), нужно перейти по адресу `/app/services/get_client.rb` 
и в константу "CITY" передать название города.


4. Добавление "api-key" в файл учетных данных:
```
$ EDITOR=vim rails credentials:edit
api_key: ******************************************
```

5. Создание и первичная загрузка базы данных: 
```
$ make install
```

6. Запуск сервера:
```
$ bin/dev
```

7. Остановка сервера:
```
$ make stop
```

8. Команда для запуска всех тестов:
```
$ make rspec
```




