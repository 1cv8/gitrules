﻿#Использовать fs

// Перем ОбщийФайлПравил;
Перем КаталогИсходныхПравил;

Перем ИменаРеквизитовКонвертации;
Перем ИменаСобытийКонвертации;
Перем ИменаСвойствКонвертации;
Перем ИменаСвойствГрупп;
Перем ИменаИсключений;
Перем ТекущийПорядок;

Перем ЭтоПравилаРегистрации;

//Служебные переменные
Перем НаименованиеКаталогаСобытий;

Процедура ИнициализироватьНачальныеПараметры()
	
	ИменаРеквизитовКонвертации = Новый Массив;
	
	//Реквизиты конвертации
	ИменаРеквизитовКонвертации.Добавить("ВерсияФормата");
	ИменаРеквизитовКонвертации.Добавить("Ид");
	ИменаРеквизитовКонвертации.Добавить("Наименование");
	ИменаРеквизитовКонвертации.Добавить("ДатаВремяСоздания");	
	ИменаРеквизитовКонвертации.Добавить("Источник");
	ИменаРеквизитовКонвертации.Добавить("Приемник");
	
	ИменаСвойствКонвертации = Новый Массив;
	ИменаСвойствКонвертации.Добавить("Параметры");
	ИменаСвойствКонвертации.Добавить("Обработки");
	
	ИменаСвойствГрупп = Новый Массив;
	ИменаСвойствГрупп.Добавить("Группа");
	ИменаСвойствГрупп.Добавить("Параметры");
	ИменаСвойствГрупп.Добавить("Обработки");
	ИменаСвойствГрупп.Добавить("Свойства");	
	ИменаСвойствГрупп.Добавить("Алгоритмы");
	ИменаСвойствГрупп.Добавить("Запросы");	
	
	МассивОбработчиков = Новый Массив;
	
	//Конвертация
	МассивОбработчиков.Добавить("ПослеЗагрузкиПравилОбмена");
	МассивОбработчиков.Добавить("ПередВыгрузкойДанных");
	МассивОбработчиков.Добавить("ПередПолучениемИзмененныхОбъектов");
	МассивОбработчиков.Добавить("ПослеВыгрузкиДанных");
	МассивОбработчиков.Добавить("ПередВыгрузкойОбъекта");
	МассивОбработчиков.Добавить("ПослеВыгрузкиОбъекта");
	МассивОбработчиков.Добавить("ПередКонвертациейОбъекта");
	МассивОбработчиков.Добавить("ПередОтправкойИнформацииОбУдалении");
	МассивОбработчиков.Добавить("ПередЗагрузкойДанных");
	МассивОбработчиков.Добавить("ПослеЗагрузкиДанных");
	МассивОбработчиков.Добавить("ПередЗагрузкойОбъекта");
	МассивОбработчиков.Добавить("ПослеЗагрузкиОбъекта");
	МассивОбработчиков.Добавить("ПриПолученииИнформацииОбУдалении");
	МассивОбработчиков.Добавить("ПослеЗагрузкиПараметров");
	МассивОбработчиков.Добавить("ПослеПолученияИнформацииОбУзлахОбмена");
	
	//ГруппаСвойств
	МассивОбработчиков.Добавить("ПередОбработкойВыгрузки");
	МассивОбработчиков.Добавить("ПередВыгрузкойСвойства");
	МассивОбработчиков.Добавить("ПриВыгрузкеСвойства");
	МассивОбработчиков.Добавить("ПослеВыгрузкиСвойства");
	МассивОбработчиков.Добавить("ПослеОбработкиВыгрузки");
	
	//Свойства
	МассивОбработчиков.Добавить("ПередВыгрузкойСвойства");
	МассивОбработчиков.Добавить("ПриВыгрузкеСвойства");
	МассивОбработчиков.Добавить("ПослеВыгрузкиСвойства");
	
	//ПравилаВыгрузкиДанных
	МассивОбработчиков.Добавить("ПередОбработкойПравила");
	МассивОбработчиков.Добавить("ПослеОбработкиПравила");
	МассивОбработчиков.Добавить("ПередВыгрузкойОбъекта");
	МассивОбработчиков.Добавить("ПослеВыгрузкиОбъекта");
	
	//ПравилаКонвертацииОбъектов
	МассивОбработчиков.Добавить("ПередВыгрузкой");
	МассивОбработчиков.Добавить("ПриВыгрузке");
	МассивОбработчиков.Добавить("ПослеВыгрузки");
	МассивОбработчиков.Добавить("ПослеВыгрузкиОбъектаВФайл");
	МассивОбработчиков.Добавить("ПослеЗагрузки");
	МассивОбработчиков.Добавить("ПослеВыгрузкиВФайл");
	МассивОбработчиков.Добавить("ПередЗагрузкой");
	МассивОбработчиков.Добавить("ПриЗагрузке");

	МассивОбработчиков.Добавить("ПередЗагрузкойОбъекта");
	МассивОбработчиков.Добавить("ПриЗагрузкеОбъекта");
	МассивОбработчиков.Добавить("ПослеЗагрузкиОбъекта");
	МассивОбработчиков.Добавить("ПоследовательностьПолейПоиска");
	
	//ПравилаРегистрацииОбъектов
	МассивОбработчиков.Добавить("ПередОбработкой");
	МассивОбработчиков.Добавить("ПриОбработке");
	МассивОбработчиков.Добавить("ПриОбработкеДополнительный");
	МассивОбработчиков.Добавить("ПослеОбработки");
	
	//ПравилаОчисткиОбъектов
	МассивОбработчиков.Добавить("ПередОбработкойПравила");
	МассивОбработчиков.Добавить("ПередУдалениемОбъекта");
	МассивОбработчиков.Добавить("ПослеОбработкиПравила");
	
	//Параметры
	МассивОбработчиков.Добавить("ПослеЗагрузкиПараметра");
	
	//Исключения для выгрузки в XML
	ИменаИсключений = Новый Массив;
	ИменаИсключений.Добавить("Правило");
	ИменаИсключений.Добавить("Запрос");
	ИменаИсключений.Добавить("Свойства");
	ИменаИсключений.Добавить("Свойство");
	ИменаИсключений.Добавить("Параметр");
	ИменаИсключений.Добавить("Значения");
	ИменаИсключений.Добавить("Значение");
	ИменаИсключений.Добавить("Алгоритм");
	ИменаИсключений.Добавить("Группа");
	ИменаИсключений.Добавить("Текст");
	
	ИменаСобытийКонвертации = МассивОбработчиков; 
	
КонецПроцедуры

Процедура ОчиститьИсходныйКаталог(КаталогФайлов) Экспорт	
	МассивФайлов = НайтиФайлы(КаталогФайлов, "*.*", Истина);
	ЧислоФайлов = МассивФайлов.ВГраница();
	// Удаление файлов и каталогов происходит в обратном порядке, чтобы избежать ошибки при удалении непустого каталога
	Для й = 1 По ЧислоФайлов Цикл
		УдалитьФайлы(МассивФайлов[ЧислоФайлов - й].ПолноеИмя);
	КонецЦикла;
КонецПроцедуры

Процедура ВыполнитьРазбор(Знач ОсновнойКаталогПравил, Знач ПутьКФайлуПравилОбмена) Экспорт
	
	ФайлПравил = Новый Файл(ПутьКФайлуПравилОбмена);
	КаталогИсходныхПравил = ОбъединитьПути(ОсновнойКаталогПравил, ФайлПравил.Имя);
	
	ОбщиеУтилиты.СоздатьКаталогРасширенный(КаталогИсходныхПравил);
	//СоздатьКаталогиРекурсивно(ОсновнойКаталогПравил, ПутьКФайлуПравилОбмена);
	
	ИнициализироватьНачальныеПараметры();
	РазобратьПравила(ПутьКФайлуПравилОбмена);
	
КонецПроцедуры

Процедура РазобратьПравила(ПутьКПравилам)
	
	Сообщить("Start rules:" + ТекущаяДата());
	
	Дерево = ПрочитатьXMLВДеревоЗначений(ПутьКПравилам);	
	ИмяКорневогоУзла = Неопределено;
	КорневойУзел = Неопределено;
	Если Дерево.Строки.Количество() > 0 Тогда	
		КорневойУзел =  Дерево.Строки[0];
		ИмяКорневогоУзла = КорневойУзел.Имя; 
	КонецЕсли;
	
	Если НЕ (ИмяКорневогоУзла = "ПравилаОбмена" Или ИмяКорневогоУзла = "ПравилаРегистрации") Тогда
		Сообщить("Стоп. Ошибка выгрузки правил. Не распознан тип правил: " + ИмяКорневогоУзла);
		УдалитьФайлы(КаталогИсходныхПравил);
		Возврат;	
	КонецЕсли;

    //ЭтоПравилаРегистрации = ИмяКорневогоУзла = "ПравилаРегистрации";
	
	КорневойУзел.Каталог = КаталогИсходныхПравил;
	
	МассивРеквизитовУзла = Новый Массив;	
	РекурсивноРазобратьДеревоПравил(КорневойУзел, ИмяКорневогоУзла, КаталогИсходныхПравил, МассивРеквизитовУзла);	
	ЗаписатьРеквизитыВФайл(МассивРеквизитовУзла, КорневойУзел, ИмяКорневогоУзла, КаталогИсходныхПравил);
	
	Сообщить("End rules:" + ТекущаяДата());
	
	
КонецПроцедуры

Процедура РекурсивноРазобратьДеревоПравил(Элемент, ИмяЭлемента, ТекущийКаталог, МассивРеквизитовУзла = Неопределено)
	
	Для Каждого ТекущаяСтрока Из Элемент.Строки Цикл
		
		Если ТекущаяСтрока.ТипСтроки = "Атрибут" Тогда
			
			Если МассивРеквизитовУзла <> Неопределено Тогда
				Если Не ТекущаяСтрока.Имя = "Текст" Тогда
					Если МассивРеквизитовУзла.Найти(ТекущаяСтрока) = Неопределено Тогда
						МассивРеквизитовУзла.Добавить(ТекущаяСтрока);		
					КонецЕсли;
				КонецЕсли;	
			КонецЕсли;
			
		Иначе
			
			ИмяЭлементаСтроки = ТекущаяСтрока.Имя;
			
			Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
			
			Если ИмяЭлементаСтроки = "Параметры" 
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
				
			ИначеЕсли ИмяЭлементаСтроки = "Текст" И (ТекущаяСтрока.Родитель.Имя = "Алгоритм" Или ТекущаяСтрока.Родитель.Имя = "Запрос") Тогда
				
				ИмяКаталогаСобытий = СоздатьКаталогСобытий(ТекущийКаталог);	
				ЗаписатьСобытиеПравилВФайл(ТекущаяСтрока, ТекущаяСтрока.Имя, ИмяКаталогаСобытий);
				
			ИначеЕсли ИмяЭлементаСтроки = "Группа" Или ИмяЭлементаСтроки = "Свойства" Или ИмяЭлементаСтроки = "Значения" Тогда
				
				МассивРеквизитовТекущегоУзла = Новый Массив;	
				Идентификатор = ?(Не ПустаяСтрока(ТекущаяСтрока.Идентификатор), ТекущаяСтрока.Идентификатор, ТекущаяСтрока.Имя);
				ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, Идентификатор);
				СоздатьКаталог(ИмяКаталогаСтроки);	
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;
				
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, МассивРеквизитовТекущегоУзла);
				
				Если ИмяЭлементаСтроки = "Группа" Тогда
					ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки);
				КонецЕсли;
				
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
				ИмяКаталогаСтроки = ОбъединитьПути(ТекущийКаталог, Идентификатор);
				СоздатьКаталог(ИмяКаталогаСтроки);
				
				ТекущаяСтрока.Каталог = ИмяКаталогаСтроки;		
				РекурсивноРазобратьДеревоПравил(ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки, МассивРеквизитовТекущегоУзла);
				
				//пишем в файл
				ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки);
				
				//Запишем двочные данные узла обработка
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
	ОбщиеУтилиты.ЗаписатьЗначениеВТекстовыйДокумент(ОбъединитьПути(ИмяКаталогаСобытий, ИмяЭлементаСтроки + ?(Расширение = Неопределено, "", "." + Расширение)), ТекущаяСтрока.Значение);	
КонецПроцедуры

Процедура ЗаписатьРеквизитыВФайл(МассивРеквизитовТекущегоУзла, ТекущаяСтрока, ИмяЭлементаСтроки, ИмяКаталогаСтроки)
	
	Если МассивРеквизитовТекущегоУзла.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	КаталогРодителя = ТекущаяСтрока.Каталог;	
	ИмяФайлаАтрибутов = ОбъединитьПути(КаталогРодителя, ТекущаяСтрока.Имя + ".xml");
	
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
	
	//ТекстXML = ЗаписьXML.Закрыть();
	// Запись = Новый ТекстовыйДокумент;
	// Запись.УстановитьТекст(ТекстXML);
	// Запись.Записать(ИмяФайлаАтрибутов, КодировкаТекста.UTF8);
	ОбщиеУтилиты.ЗаписатьЗначениеВТекстовыйДокумент(ИмяФайлаАтрибутов, ЗаписьXML.Закрыть());
	
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
		
		//Если Строка.Имя = "ПередОбработкойВыгрузки" Тогда
		//	Стоп = Истина;
		//КонецЕсли;
		
		
		//Для Каждого СтрокаПодчиненнаяСтрока Из СтрокаУзла.Строки Цикл
		ЗаписатьXMLЭлемента(ЗаписьXML, Строка);	
		//КонецЦикла;
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(СтрокаУзла.Значение) Тогда
		ЗаписьXML.ЗаписатьТекст(СтрокаУзла.Значение);
	КонецЕсли;	
	
	ЗаписьXML.ЗаписатьКонецЭлемента();
	
КонецПроцедуры

Функция ПрочитатьXMLВДеревоЗначений(Путь)
	
	ЭтоПравилаРегистрации = Ложь;
	Дерево = ПолучитьСтруктуруДерева();	
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
				НоваяСтрокаАтрибут.Значение = СокрЛП(ЧтениеXML.Значение);
				НоваяСтрокаАтрибут.ТипСтроки = "Атрибут";	
				
				Если ЧтениеXML.Имя = "Имя" Тогда
					НоваяСтрока.Идентификатор =  НоваяСтрокаАтрибут.Значение;
				КонецЕсли;
				
			КонецЦикла;
			
			ПрочитатьXMLРекурсивно(ЧтениеXML, НоваяСтрока.Строки);
			
		ИначеЕсли ЧтениеXML.ТипУзла = ТипУзлаXML.Текст Тогда
			
			ТекущаяСтрокаДерева.Родитель.Значение = СокрЛП(ЧтениеXML.Значение);
			
			Если (ТекущаяСтрокаДерева.Родитель.Имя = "Код" Или ТекущаяСтрокаДерева.Родитель.Имя = "Номер" Или ТекущаяСтрокаДерева.Родитель.Имя = "Имя") И Не ЭтоПравилаРегистрации Тогда
				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение); 	
			ИначеЕсли ЭтоПравилаРегистрации И (ТекущаяСтрокаДерева.Родитель.Имя = "Номер" Или ТекущаяСтрокаДерева.Родитель.Имя = "Имя" Или ТекущаяСтрокаДерева.Родитель.Имя = "Наименование") Тогда
				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение); 		
			ИначеЕсли ЭтоПравилаРегистрации И ТекущаяСтрокаДерева.Родитель.Имя = "Тип" И ТекущаяСтрокаДерева.Родитель.Родитель.Имя = "Элемент" Тогда
				ТекущаяСтрокаДерева.Родитель.Родитель.Идентификатор = СокрЛП(ЧтениеXML.Значение); 	
			ИначеЕсли ТекущаяСтрокаДерева.Родитель.Имя = "Порядок" Тогда
				ТекущаяСтрокаДерева.Родитель.Родитель.Порядок = Число(СокрЛП(ЧтениеXML.Значение)); 
			КонецЕсли;
			
		ИначеЕсли ЧтениеXML.ТипУзла = ТипУзлаXML.КонецЭлемента Тогда
			
			Возврат;
			
		Конецесли;
	КонецЦикла;
	
КонецПроцедуры

Функция ПолучитьСтруктуруДерева()
	
	Дерево = Новый ДеревоЗначений;
	Дерево.Колонки.Добавить("Имя"); 
	Дерево.Колонки.Добавить("Идентификатор");
	Дерево.Колонки.Добавить("Значение");
	Дерево.Колонки.Добавить("Порядок");
	Дерево.Колонки.Добавить("ТипСтроки");
	Дерево.Колонки.Добавить("Каталог");
	//Дерево.Колонки.Добавить("Содержимое");
	Возврат Дерево;
	
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

//Инициализация модуля
НаименованиеКаталогаСобытий = "Ext";
