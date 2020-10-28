#Использовать 1commands
#Использовать gitrunner

Перем ОсновнойКаталогПравил;
Перем ВыгружатьВВыбранныйКаталог;

Процедура Инициализация()

	Сообщить("Запущен менеджер правил");

КонецПроцедуры

Процедура ЗапуститьВыгрузкуПравилВФайлы(КаталогИзПараметров, КаталогПроекта, ИндексироватьИзменения = Истина) Экспорт

	Сообщить("START precommit gitrules");
	УстановитьОсновнойКаталог(КаталогИзПараметров);
	СписокФайлов = ПолучитьСписокПравил();
	УстановитьОсновнойКаталог(КаталогПроекта);
	Для Каждого ПутьКФайлу Из СписокФайлов Цикл
		Сообщить("FILE: " + ПутьКФайлу);
		КаталогПравил = СоздатьКаталогиДляПравил(КаталогИзПараметров, КаталогПроекта, ПутьКФайлу);
		УстановитьОсновнойКаталог(КаталогПравил);
		РазложитьФайлПравила(ПутьКФайлу);	
		РазобратьПравилаОбмена.ВыполнитьРазбор(КаталогПравил, ПутьКФайлу);
	КонецЦикла;

	Если ИндексироватьИзменения Тогда
		Сообщить("Add to index git");
		ГитРепозиторий = Новый ГитРепозиторий();
		ГитРепозиторий.УстановитьРабочийКаталог(КаталогИзПараметров);
		ГитРепозиторий.ДобавитьФайлВИндекс(".");
	КонецЕсли;
	Сообщить("END");

КонецПроцедуры

Процедура РазложитьПравилаКонвертации(Знач ПутьКПравилам, Знач КаталогРаспаковки) Экспорт
	
	Сообщить("START Export");
	РазобратьПравилаОбмена.ВыполнитьРазбор(КаталогРаспаковки, ПутьКПравилам, ВыгружатьВВыбранныйКаталог);
	Сообщить("END");

КонецПроцедуры

Процедура СобратьПравилаКонвертации(Знач КаталогИсходников, Знач КаталогСборки) Экспорт
	Сообщить("START Assembly");
	СобратьПравилаОбмена.ВыполнитьСборку(КаталогИсходников, КаталогСборки);
	Сообщить("END");
КонецПроцедуры

Процедура ИнициализироватьКаталогИсходников(КаталогПроекта) Экспорт

	Файл = Новый Файл(КаталогПроекта);
	Если Файл.Существует() Тогда
		ОбщийФункционал.ОчиститьИсходныйКаталог(КаталогПроекта);
		Попытка
			УдалитьФайлы(КаталогПроекта);
		Исключение
			Сообщить("Не удалось удалить каталог " + КаталогПроекта);
		КонецПопытки;
	КонецЕсли;
	СоздатьКаталог(КаталогПроекта);

КонецПроцедуры

Процедура УстановитьЗначениеВыгружатьВВыбранныйКаталог(Знач Значение) Экспорт
	ВыгружатьВВыбранныйКаталог =  Значение;
КонецПроцедуры

Процедура УстановитьОсновнойКаталог(Знач Значение) Экспорт
	ОсновнойКаталогПравил = Значение; 
КонецПроцедуры

Функция ПолучитьОсновнойКаталог() Экспорт
	Возврат ОсновнойКаталогПравил; 
КонецФункции

Функция ПолучитьСписокПравил() Экспорт
	Массив = Новый Массив;
	МассивФайлов = НайтиФайлы(ОсновнойКаталогПравил, "*.xml", Истина);
	Для Каждого Файл Из МассивФайлов Цикл
		Массив.Добавить(Файл.ПолноеИмя);
	КонецЦикла;
	Возврат Массив;
КонецФункции

Процедура РазложитьФайлПравила(ПутьКФайлу) Экспорт
	РазобратьПравилаОбмена.ВыполнитьРазбор(ОсновнойКаталогПравил, ПутьКФайлу);
КонецПроцедуры

Процедура ДобавитьПравилаВИндексGIT() Экспорт
	Команда = Новый Команда;
	Команда.УстановитьРабочийКаталог(ОсновнойКаталогПравил);
	Команда.УстановитьКоманду("git add *");
	КодВозврата = Команда.Исполнить();
КонецПроцедуры

Функция СоздатьКаталогиДляПравил(КаталогИсходников, КаталогПроекта, ПутьКПравилам) Экспорт

	Файл = Новый Файл(ПутьКПравилам);
	Каталог = ОбщийФункционал.ПолучитьПутьВРабочемКаталоге(Файл.Путь, КаталогИсходников);
	Файл = Неопределено;
	МассивКаталогов = ОбщийФункционал.РазложитьСтрокуВМассивПодстрок(Каталог, ПолучитьРазделительПути()); 
	Если МассивКаталогов.Количество() = 0 Тогда
		Возврат КаталогИсходников;
	КонецЕсли;

	ТекущийКаталог = КаталогПроекта;
	Для Каждого ЭлементМассива Из МассивКаталогов Цикл
		ТекущийКаталог = ОбъединитьПути(ТекущийКаталог, ЭлементМассива);
		Если Не ОбщийФункционал.ЭтотКаталогСуществует(ТекущийКаталог) Тогда
			СоздатьКаталог(ТекущийКаталог);
		КонецЕсли;
	КонецЦикла;

	Возврат ТекущийКаталог;

КонецФункции

ОсновнойКаталогПравил = "";
ВыгружатьВВыбранныйКаталог = Ложь;

Инициализация();