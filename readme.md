## GitRules - версионирование правил обмена 1С с помощью git ##

### Описание
----
С помощью этого проекта можно версионировать изменения правил обмена 1С и выгружать на git. 
Реализованы следующие возможности:
* Распаковка (разборка) правил на файлы и папки.
  + Поддержка разбора правил обмена.
  + Поддержка разбора правил регистрации.
* Сборка правил из файлов и папок.
  + Поддержка сборки правил обмена.

### Системные требования

* 1C: Предприятие 8.2.19 и старше
* git (https://git-scm.com/)
* OneScript 1.0.11 и старше (http://oscript.io/)
* Библиотеки OneScript (https://github.com/oscript-library)
  + cmdline 0.4.1 и старше (https://github.com/oscript-library/cmdline)
  + 1commands 0.8 и старше (https://github.com/oscript-library/1commands)
  + logos 0.5 и старше (https://github.com/oscript-library/logos)

### Установка gitrules

При соблюдении системных требований, качаем акткальный релиз по ссылке: https://github.com/otymko/gitrules/releases
Для установки пакета, нужно выполнить команду:

```
$ opm install -f "path/to/file.ospx"
```

где path/to/file.ospx - путь к файлу реализа пакета для onescript.

### Установка в проект правил на GIT

Для установки в репозиторий GIT нужно выполнить команду:

```
$ gitrules install
```

Для удаления в репозитории проекта нужно выполнить команду:

```
$ gitrules remove
```

### Консольное приложение gitrules ###
Список команд:
* help - справка по командам
* version - версия приложения
* install - установить hook gitrules в git проект
* remove - удалить hook gitrules в git проекте
* export - распаковка правил конвертации
* assembly - сборка правил конвертации

### help - справка по командам ###

Выводит справка по команде консольного приложения.
Параметры:
* <Команда> - команда, по которой нужно получить справку.

```
$ gitrules help export
```

### version - версия приложения ###

Выводит версию консольного приложения.

```
$ gitrules version
```

### install - установить hook gitrules в git проект ###

Устанавливается библиотеку gitrules в проект git. Установка ведется в каталог ./.git/hooks.

```
$ gitrules install
```

### remove - удалить hook gitrules в git проекте ###

Удаляет библиотеку gitrules из проекта git. Поиск ведется в каталоге ./.git/hooks.

```
$ gitrules help remove
```

### export - распаковка правил конвертации ###

Выполняет распаковку (разборку) правил конвертации.
Параметры:
* <ПутьКФайлуПравил> - путь до файла правил конвертации.
* <КаталогРаспаковки> - каталог для распаковки (разборка) правил конвертации.
Например:
```
$ gitrules export ExchangeRules.xml ./src
```

### assembly - сборка правил конвертации ###

Выполняет сборку правил конвертации в указанный каталог.
Параметры:
* <КаталогИсходников> - каталог с распакованными правилами конвертации.
* <КаталогСборки> - каталог для сборки правил конвертации.
```
$ gitrules assembly ./src/ExchangeRules.xml ./src2
```
