# Prueba Garoo

* Calculo de 0 en factorial
    Al instalar el aplicativo saldra un formulario para estos calculos. El código se encuentra en **app/controllers/functions_controller.rb** en el metodo **calculate_factorial**

* Traducción numeros a letras
    El código se encuentra ubicado en **app/services/numbers_to_words_service.rb**

* Modelado de datos
  * Codigo SQL para la estrutura de la base de datos en **app/db/structure.sql**
  * Consulta SQL del promedio de los alumnos en cada curso se encuentra en **app/db/views/notes_by_students_v02.sql**
  * Consulta SQL de los alumnos con mas de un curso y promedio menor a 4.0 en **app/db/views/red_studens_v01.sql**

* Diseño Orientado a Objetos
  * Modelos para el diseño del punto anterior dentro de **app/models/** obvianto la carpeta **cardgame**
  * Clases para mazo de cartas en **app/models/cardgame**

* Frontend
  * URL para el calendario semanal **http://dominio/calendars/index**
  * Código CSS en **app/assets/stylesheets/calendars.scss**
  * Código JS **app/assets/javascripts/calendars.js**
  * JSON en **public/dates.json** y URL estática **http://dominio/dates.json**
