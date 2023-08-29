﻿#Использовать fs

Перем КаталогИсходныхПравил;
Перем ИменаРеквизитовКонвертации;
Перем ИменаСобытийКонвертации;
Перем ИменаСвойствКонвертации;
Перем ИменаСвойствГрупп;
Перем ИменаИсключений;
Перем ТекущийПорядок;
Перем ЭтоПравилаРегистрации;
Перем НаименованиеКаталогаСобытий;
Перем ДопустимыеИмяУзловРодителей;

Процедура ИнициализироватьНачальныеПараметры()
	
	СтруктураПараметров = ОбщийФункционал.ПолучитьПараметрыПравил();
	ИменаСобытийКонвертации = СтруктураПараметров.ИменаСобытийКонвертации;
	ИменаРеквизитовКонвертации = СтруктураПараметров.ИменаРеквизитовКонвертации;
	ИменаСвойствКонвертации = СтруктураПараметров.ИменаСвойствКонвертации;
	ИменаСвойствГрупп = СтруктураПараметров.ИменаСвойствГрупп;
	ИменаСобытийКонвертации = СтруктураПараметров.ИменаСобытийКонвертации;
	ИменаИсключений = СтруктураПараметров.ИменаИсключений;
	
КонецПроцедуры

Процедура ВыполнитьРазбор(
	Знач ОсновнойКаталогПравил, 
	Знач ПутьКФайлуПравилОбмена, 
	Знач ВыгружатьВВыбранныйКаталог = Ложь) Экспорт
	
	ФайлПравил = Новый Файл(ПутьКФайлуПравилОбмена);
	Если ВыгружатьВВыбранныйКаталог Тогда
		КаталогИсходныхПравил = ОсновнойКаталогПравил;		
	Иначе
		КаталогИсходныхПравил = ОбъединитьПути(ОсновнойКаталогПравил, ФайлПравил.Имя);
		ОбщийФункционал.СоздатьКаталогРасширенный(КаталогИсходныхПравил);
	КонецЕсли;
	ИнициализироватьНачальныеПараметры();
	РазобратьПравила(ПутьКФайлуПравилОбмена);
	
КонецПроцедуры

Процедура РазобратьПравила(ПутьКПравилам)
	
	Дерево = ПрочитатьXMLВДеревоЗначений(ПутьКПравилам);	
	ИмяКорневогоУзла = Неопределено;
	КорневойУзел = Неопределено;
	Если Дерево.Строки.Количество() > 0 Тогда	
		КорневойУзел =  Дерево.Строки[0];
		ИмяКорневогоУзла = КорневойУзел.Имя; 
	КонецЕсли;
	
	Если НЕ (ИмяКорневогоУзла = "ПравилаОбмена" Или ИмяКорневогоУзла = "ПравилаРегистрации") Тогда
		Сообщить("Стоп. Ошибка выгрузки правил. Не распознан вид правил: " + ИмяКорневогоУзла);
		УдалитьФайлы(КаталогИсходныхПравил);
		Возврат;	
	КонецЕсли;
	
	КорневойУзел.Каталог = КаталогИсходныхПравил;	
	МассивРеквизитовУзла = Новый Массив;	
	РекурсивноРазобратьДеревоПравил(КорневойУзел, ИмяКорневогоУзла, КаталогИсходныхПравил, МассивРеквизитовУзла);	
	ЗаписатьРеквизитыВФайл(МассивРеквизитовУзла, КорневойУзел, ИмяКорневогоУзла, КаталогИсходныхПравил);
	
КонецПроцедуры

Процедура РекурсивноРазобратьДеревоПравил(Элемент, ИмяЭлемента, ТекущийКаталог, МассивРеквизитовУзла = Неопределено)
	
	Для Каждого ТекущаяСтрока Из Элемент.Строки Цикл
		
		Если ТекущаяСтрока.ТипСтроки = "Атрибут" Тогда
			
			Если МассивРеквизитовУзла <> Неопределено
				И НЕ ТекущаяСтрока.Имя = "Текст" 
				И МассивРеквизитовУзла.Найти(ТекущаяСтрока) = Неопределено Тогда
					
					МассивРеквизитовУзла.Добавить(ТекущаяСтрока);
	
			КонецЕсли;
			
		Иначе
			
			ИмяЭлементаСтроки = ТекущаяСтрока.Имя;
			
			Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
			
			Если (ИмяЭлементаСтроки = "Параметры" И НЕ ТекущаяСтрока.Родитель.Имя = "Алгоритм")
				Или ИмяЭлементаСтроки = "Обработки" 
				Или ИмяЭлементаСтроки = "ПравилаКонвертацииОбъектов" 
				Или ИмяЭлементаСтроки = "ПравилаВыгрузкиДанных"
				Или ИмяЭлементаСтроки = "ПравилаОчисткиДанных"
				Или ИмяЭлементаСтроки = "Алгоритмы"
				Или ИмяЭлементаСтроки = "Запросы" 
				Или ИмяЭлементаСтроки = "СоставПланаОбмена" 
				Или ИмяЭлементаСтроки = "ПравилаРегистрацииОбъектов"
				Или ИмяЭлементаСтроки = "ОтборПоСвойствамПланаОбмена" 
				Или ИмяЭлементаСтроки = "ОтборПоСвойствамОбъекта" 
				Или ИмяЭлементаСтроки = "ТаблицаСвойствОбъекта" 
				Или ИмяЭлементаСтроки = "ТаблицаСвойствПланаОбмена" Тогда
				
				ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, ИмяЭлементаСтроки); 
				СоздатьКаталог(ИмяКаталогаСтроки);					
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;	
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки);
				
			ИначеЕсли ИменаСобытийКонвертации.Найти(ИмяЭлементаСтроки) <> Неопределено Тогда
				
				ИмяКаталогаСобытий = СоздатьКаталогСобытий(ТекущийКаталог);		
				ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСобытий);
				
			ИначеЕсли ИмяЭлементаСтроки = "Текст" 
				И (ТекущаяСтрока.Родитель.Имя = "Алгоритм" 
				Или ТекущаяСтрока.Родитель.Имя = "Запрос") Тогда
				
				ИмяКаталогаСобытий = СоздатьКаталогСобытий(ТекущийКаталог);	
				ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, ТекущаяСтрока.Имя, ИмяКаталогаСобытий);
				
			ИначеЕсли ИмяЭлементаСтроки = "Параметры" И ТекущаяСтрока.Родитель.Имя = "Алгоритм" Тогда
				
				ИмяКаталогаСобытий = СоздатьКаталогСобытий(ТекущийКаталог);	
				ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, ТекущаяСтрока.Имя, ИмяКаталогаСобытий, Неопределено);	
				
			ИначеЕсли ИмяЭлементаСтроки = "Группа" Или ИмяЭлементаСтроки = "Свойства" Или ИмяЭлементаСтроки = "Значения" Тогда
				
				МассивРеквизитовТекущегоУзла = Новый Массив;	
				Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
				ОбщийФункционал.ЗаменитьВСтрокеЗапрещенныеСимволы(Идентификатор);
				ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, Идентификатор);
				СоздатьКаталог(ИмяКаталогаСтроки);	
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;
				
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, МассивРеквизитовТекущегоУзла);
				
				Если ИмяЭлементаСтроки = "Группа" Тогда
					ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки);
				КонецЕсли;
				
			// РСВ 28/08/23
			ИначеЕсли ИмяЭлементаСтроки = "Свойство" 
				ИЛИ ИмяЭлементаСтроки = "Значение" Тогда

				МассивРеквизитовТекущегоУзла = Новый Массив;
				
				Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
				ОбщийФункционал.ЗаменитьВСтрокеЗапрещенныеСимволы(Идентификатор);
				//ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, Идентификатор);
				ИмяКаталогаСтроки = ТекущийКаталог;
				//СоздатьКаталог(ИмяКаталогаСтроки);
				
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;		
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, МассивРеквизитовТекущегоУзла);
				
				ИмяФайла = "" + ИмяЭлементаСтроки + "_" + СокрЛП(Идентификатор);

				// пишем в файл
				ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, ИмяФайла); // РСВ 28/08/23 + ИмяФайла



			ИначеЕсли ИмяЭлементаСтроки = "Правило" 
				Или ИмяЭлементаСтроки = "Запрос" 
				Или ИмяЭлементаСтроки = "Алгоритм" 
				Или ИмяЭлементаСтроки = "Значение" 
				Или ИмяЭлементаСтроки = "Свойство" 
				Или ИмяЭлементаСтроки = "Параметр" 
				Или ИмяЭлементаСтроки = "Обработка" 
				Или ИмяЭлементаСтроки = "ЭлементОтбора" Или ИмяЭлементаСтроки = "Элемент" Тогда
				
				МассивРеквизитовТекущегоУзла = Новый Массив;
				
				Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
				ОбщийФункционал.ЗаменитьВСтрокеЗапрещенныеСимволы(Идентификатор);
				ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, Идентификатор);
				СоздатьКаталог(ИмяКаталогаСтроки);
				
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;		
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, МассивРеквизитовТекущегоУзла);
				
				// пишем в файл
				ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки);
				
				// Запишем двочные данные узла обработка
				Если ИмяЭлементаСтроки = "Обработка" Тогда
					ЗначениеУзла = ТекущаяСтрока.Значение;
					Если Не ПустаяСтрока(ЗначениеУзла) Тогда
						ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, "ДвоичныеДанные", ТекущаяСтрока.Каталог, Неопределено);	
					КонецЕсли;
				КонецЕсли;
			Иначе
				
				Если МассивРеквизитовУзла = Неопределено Тогда
					МассивРеквизитовУзла = Новый Массив;
				КонецЕсли;
				
				КаталогРодителя = ТекущаяСтрока.Родитель.Каталог;
				Если ЗначениеЗаполнено(КаталогРодителя) Тогда				
					МассивРеквизитовУзла.Добавить(ТекущаяСтрока);	
				КонецЕсли;
				
			КонецЕсли;	
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСобытий, Расширение = "bsl")

	ОбщийФункционал.ЗаписатьЗначениеВТекстовыйДокумент(
		ОбъединитьПути(ИмяКаталогаСобытий, ИмяЭлементаСтроки + ?(Расширение = Неопределено, "", "." + Расширение)), 
		ТекущаяСтрока.Значение);
			
КонецПроцедуры

Процедура ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, ИмяФайлаБезРасширения = "") // РСВ 28/08/23 + ИмяФайлаБезРасширения
	
	Если МассивРеквизитовТекущегоУзла.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	КаталогРодителя = ТекущаяСтрока.Каталог;	
	Если НЕ ЗначениеЗаполнено(ИмяФайлаБезРасширения) Тогда // РСВ 28/08/23 + ИмяФайла
		ИмяФайлаАтрибутов = ОбъединитьПути(КаталогРодителя, ТекущаяСтрока.Имя + ".xml");
	Иначе
		ИмяФайлаАтрибутов = ОбъединитьПути(КаталогРодителя, ИмяФайлаБезРасширения + ".xml");
	КонецЕсли;
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку();	
	ЗаписьXML.ЗаписатьНачалоЭлемента(ТекущаяСтрока.Имя);		
	Для Каждого СтрокаДерева Из МассивРеквизитовТекущегоУзла Цикл
		
		Если ЭтоТегИсключение(СтрокаДерева.Имя) Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			ЗаписатьXMLЭлемента(ЗаписьXML, СтрокаДерева);
		Исключение
			Сообщить("Не удалось " + ОписаниеОшибки());	
			Прервать;
		КонецПопытки;
	КонецЦикла;
	
	ЗаписьXML.ЗаписатьКонецЭлемента();	
	ОбщийФункционал.ЗаписатьЗначениеВТекстовыйДокумент(ИмяФайлаАтрибутов, ЗаписьXML.Закрыть());
	
КонецПроцедуры

Процедура ЗаписатьXMLЭлемента(ЗаписьXML, СтрокаУзла)
	
	Если СтрокаУзла.Имя = "Текст" Или ИменаСобытийКонвертации.Найти(СтрокаУзла.Имя) <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если СтрокаУзла.ТипСтроки = "Атрибут" Тогда
		ЗаписьXML.ЗаписатьАтрибут(СтрокаУзла.Имя, СтрокаУзла.Значение);
		Возврат;
	КонецЕсли;
	
	МассивАтрибутов = Новый Массив;
	МассивСвойств = Новый Массив;
	
	Для Каждого Строка Из СтрокаУзла.Строки Цикл
		
		Если Строка.ТипСтроки = "Атрибут" Тогда
			МассивАтрибутов.Добавить(Строка);	
		Иначе
			МассивСвойств.Добавить(Строка);	
		КонецЕсли;
		
	КонецЦикла;
	
	ЗаписьXML.ЗаписатьНачалоЭлемента(СтрокаУзла.Имя);
	
	Для Каждого Строка Из МассивАтрибутов Цикл
		
		ЗаписьXML.ЗаписатьАтрибут(Строка.Имя, Строка.Значение);	
		
	КонецЦикла;
	
	Для Каждого Строка Из МассивСвойств Цикл
		ЗаписатьXMLЭлемента(ЗаписьXML, Строка);	
	КонецЦикла;
	
	Если ЗначениеЗаполнено(СтрокаУзла.Значение) Тогда
		ЗаписьXML.ЗаписатьТекст(СтрокаУзла.Значение);
	КонецЕсли;	
	
	ЗаписьXML.ЗаписатьКонецЭлемента();
	
КонецПроцедуры

Функция ПрочитатьXMLВДеревоЗначений(Путь)
	
	ЭтоПравилаРегистрации = Ложь;
	Дерево = ОбщийФункционал.ПолучитьСтруктуруДереваПравил();	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(Путь);
	ПрочитатьXMLРекурсивно(ЧтениеXML, Дерево.Строки);
	ЧтениеXML.Закрыть();
	
	Возврат Дерево;
	
КонецФункции

Функция ЭтоТегИсключение(Значение)
	
	Возврат ИменаИсключений.Найти(Значение) <> Неопределено Или ИменаСобытийКонвертации.Найти(Значение) <> Неопределено;
	
КонецФункции

Процедура ПрочитатьXMLРекурсивно(ЧтениеXML, ТекущаяСтрокаДерева)
	
	Пока ЧтениеXML.Прочитать() Цикл
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда
			
			Если Не ЭтоПравилаРегистрации И ЧтениеXML.Имя = "ПравилаРегистрации" Тогда
				ЭтоПравилаРегистрации = Истина;
			КонецЕсли;
			
			НоваяСтрока = ТекущаяСтрокаДерева.Добавить();
			НоваяСтрока.Имя = ЧтениеXML.Имя;
			НоваяСтрока.ТипСтроки = "Элемент";
			
			Пока ЧтениеXML.ПрочитатьАтрибут() Цикл
				
				НоваяСтрокаАтрибут = НоваяСтрока.Строки.Добавить();
				НоваяСтрокаАтрибут.Имя = ЧтениеXML.Имя;
				НоваяСтрокаАтрибут.Значение = ЧтениеXML.Значение;
				НоваяСтрокаАтрибут.ТипСтроки = "Атрибут";	
				
				Если ЧтениеXML.Имя = "Имя" Тогда
					НоваяСтрока.Идентификатор =  СокрЛП(НоваяСтрокаАтрибут.Значение); // РСВ 28/08/23
				КонецЕсли;
				
			КонецЦикла;
			
			ПрочитатьXMLРекурсивно(ЧтениеXML, НоваяСтрока.Строки);
			
			// РСВ 28/08/23
			 ПереопределитьИдентификаторУзла(НоваяСтрока);

		ИначеЕсли ЧтениеXML.ТипУзла = ТипУзлаXML.Текст Тогда
			
			ТекущаяСтрокаДерева.Родитель.Значение = ЧтениеXML.Значение;

			ИмяУзлаРодителя = ТекущаяСтрокаДерева.Родитель.Имя;

			Если Не ЭтоПравилаРегистрации 
				И ЭтоДопустимоеИмяРодителяПравила(ИмяУзлаРодителя, "ПравилаОбмена") Тогда

				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение);	

			КонецЕсли;

			Если ЭтоПравилаРегистрации 
				И ЭтоДопустимоеИмяРодителяПравила(ИмяУзлаРодителя, "ПравилаРегистрации") Тогда

				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение);

			КонецЕсли;

			Если ЭтоПравилаРегистрации 
				И ИмяУзлаРодителя = "Тип" 
				И ТекущаяСтрокаДерева.Родитель.Родитель.Имя = "Элемент" Тогда

				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение);

			КонецЕсли;

			Если ИмяУзлаРодителя = "Порядок" Тогда

				ТекущаяСтрокаДерева.Родитель.Родитель.Порядок = Число(СокрЛП(ЧтениеXML.Значение)); 

			КонецЕсли;
			
		ИначеЕсли ЧтениеXML.ТипУзла = ТипУзлаXML.КонецЭлемента Тогда
			
			Возврат;

		Иначе

			Продолжить;
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция ЭтоДопустимоеИмяРодителяПравила(Имя, ВидПравил)

	КоллекцияИмена = ДопустимыеИмяУзловРодителей[ВидПравил];
	Возврат КоллекцияИмена.Найти(Имя) <> Неопределено;

КонецФункции

Функция СоздатьКаталогСобытий(ТекущийКаталог)
	
	ИмяКаталога = ОбъединитьПути(ТекущийКаталог, НаименованиеКаталогаСобытий);
	Файл = Новый Файл(ИмяКаталога);
	Если Не Файл.Существует() Тогда
		СоздатьКаталог(ИмяКаталога);	
	КонецЕсли;
	Файл = Неопределено;
	
	Возврат ИмяКаталога;
	
КонецФункции

// РСВ 28/08/23
Процедура ПереопределитьИдентификаторУзла(СтрокаДерева)

	Если СтрокаДерева.Имя = "Свойство"
		ИЛИ СтрокаДерева.Имя = "Значение"
		Тогда

		СтрокаН = ЭлементДереваПоПути(СтрокаДерева, "Наименование");
		Если СтрокаН <> Неопределено
			И ЗначениеЗаполнено(СтрокаН.Значение)
			Тогда
			
			СтрокаДерева.Идентификатор = СокрЛП(СтрокаН.Значение);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// РСВ 28/08/23
Функция ЭлементДереваПоПути(Знач СтрокаДерева, Знач Путь)

	МассивЭлементовПути = Путь;
	Если ТипЗнч(Путь) = Тип("Строка") Тогда
		МассивЭлементовПути = СтрРазделить(Путь, "\");
	КонецЕсли;

	Если МассивЭлементовПути.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	ЭлементПути = МассивЭлементовПути[0];
	СтрокаПоПути = Неопределено;

	Для Каждого СтрокаН Из СтрокаДерева.Строки Цикл

		Если СтрокаН.Имя = ЭлементПути Тогда
			СтрокаПоПути = СтрокаН;	
		КонецЕсли;

	КонецЦикла;

	Если СтрокаПоПути = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Если МассивЭлементовПути.Количество() = 1 Тогда
		Возврат СтрокаПоПути;
	КонецЕсли;

	МассивЭлементовПути.Удалить(0);

	Возврат ЭлементДереваПоПути(СтрокаПоПути, МассивЭлементовПути);

КонецФункции


// Инициализация модуля
НаименованиеКаталогаСобытий = "Ext";

ДопустимыеИмяУзловРодителей = Новый Структура;
ДопустимыеИмяУзловРодителей.Вставить("ПравилаРегистрации", Новый Массив);
ДопустимыеИмяУзловРодителей.Вставить("ПравилаОбмена", Новый Массив);

ДопустимыеИмяУзловРодителей.ПравилаРегистрации.Добавить("Номер");
ДопустимыеИмяУзловРодителей.ПравилаРегистрации.Добавить("Имя");
ДопустимыеИмяУзловРодителей.ПравилаРегистрации.Добавить("Наименование");

ДопустимыеИмяУзловРодителей.ПравилаОбмена.Добавить("Код");
ДопустимыеИмяУзловРодителей.ПравилаОбмена.Добавить("Номер");
ДопустимыеИмяУзловРодителей.ПравилаОбмена.Добавить("Имя");
