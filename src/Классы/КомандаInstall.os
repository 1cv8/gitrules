///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с реализацией работы команды
//
///////////////////////////////////////////////////////////////////////////////

Процедура НастроитьКоманду(Знач Команда, Знач Парсер) Экспорт

КонецПроцедуры // НастроитьКоманду

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие - Соответствие ключей командной строки и их значений
//   Приложение - Модуль - Модуль менеджера приложения
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды, Знач Приложение) Экспорт
	
	КаталогПроекта = Новый Файл(ТекущийКаталог() + "\.git");
	Если Не КаталогПроекта.Существует() Тогда
		Сообщить("Этот каталог не является репозиторием GIT");
		Сообщить("Операция прервана");
		Возврат Приложение.РезультатыКоманд().НеверныеПараметры
	КонецЕсли;
	Попытка
		МассивФайлов = НайтиФайлы(Приложение.ПолучитьКаталогУтилитДляУстановки() + "\", "*");
		Для Каждого Файл Из МассивФайлов Цикл
			КопироватьФайл(Файл.ПолноеИмя, КаталогПроекта.ПолноеИмя + "\hooks\" + Файл.Имя)
		КонецЦикла;
		Сообщить("Установка завершена");
	Исключение
		Сообщить("Не удалось установить gitrules по причине: " + ОписаниеОшибки());
		Сообщить("Операция прервана");
	КонецПопытки;
	Возврат Приложение.РезультатыКоманд().Успех;
	
КонецФункции // ВыполнитьКоманду
