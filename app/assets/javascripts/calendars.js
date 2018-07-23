var ajaxGet = function (url, callback) {
  var callback = (typeof callback == 'function' ? callback : false), xhr = null;
  try {
    xhr = new XMLHttpRequest();
  } catch (e) {
    try {
      xhr = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  if (!xhr)
         return null;
  xhr.open("GET", url,true);
  xhr.onreadystatechange=function() {
    if (xhr.readyState==4 && callback) {
      callback(xhr.responseText)
    }
  }
  xhr.send(null);
  return xhr;
}

ajaxGet('http://localhost:3000/dates.json', function (response) {
      response = JSON.parse(response);
      createHours(response);
    });
/*
  - Ver diferencia entre hora empieza y hora termino 
    para crear los div y los estilos de cada cita
  - Dependiendo del primero creo los div donde iran las citas
*/

function createHours(appointments){
  var max = 0;
  var min = 24;
  appointments.citas.forEach(function (item, index) {
    Object.values(item).forEach(function(day){
        if(min > getMinHour(day)){
          min = getMinHour(day);
        }

        if(max < getMaxHour(day)){
          max = getMaxHour(day);
        }
    });
  });

  var initialDate = new Date();
  initialDate.setSeconds(0);
  initialDate.setHours(min - 1);
  initialDate.setMinutes(30);
  var endDate = new Date();
  endDate.setHours(max);
  endDate.setSeconds(0);
  while (initialDate < endDate) {
    var date = addMinutes(initialDate, 30);
    createHour(date);
    initialDate = date;
  }

  var date = new Date();
  date.setSeconds(0);
  date.setHours(min - 1);
  date.setMinutes(30);
  date = addMinutes(date, 30);
  createAppointments(appointments, date);
}

function getMinHour(day) {
  var start = 24;
  day.forEach(function(date) {
    if(parseInt(date.hora_inicio.split(':')[0]) < start){
      start = parseInt(date.hora_inicio.split(':')[0]);
    }
  });
  return start;
}

function getMaxHour(day) {
  var start = 0;
  day.forEach(function(date) {
    if(parseInt (date.hora_termino.split(':')[0]) > start){
      start = parseInt(date.hora_termino.split(':')[0]);
    }
  });
  return start;
}

function addMinutes(date, minutes) {
  return new Date(date.getTime() + minutes*60000);
}

function createHour(value){
  var hour = value.toTimeString().split(':')[0];
  var minutes = value.toTimeString().split(':')[1];
  var div = document.createElement("div");
  div.className = "description hour";
  div.innerText = hour+':'+minutes;
  var parent = document.getElementById("hours_section");
  parent.appendChild(div);
}

function createAppointments(appointments, date) {
  var init = new Date(date);
  appointments.citas[0].lunes.forEach(function (item) {
    createMondayAppointment(item.nombre, item.hora_inicio, item.hora_termino, init);
    init.setHours(parseInt(item.hora_termino.split(':')[0]));
    init.setMinutes(parseInt(item.hora_termino.split(':')[1]));
  })
  var init = new Date(date);
  appointments.citas[1].martes.forEach(function (item) {
    createTuesdayAppointment(item.nombre, item.hora_inicio, item.hora_termino, init);
    init.setHours(parseInt(item.hora_termino.split(':')[0]));
    init.setMinutes(parseInt(item.hora_termino.split(':')[1]));
  })
  var init = new Date(date);
  appointments.citas[2].miercoles.forEach(function (item) {
    createWednesdayAppointment(item.nombre, item.hora_inicio, item.hora_termino, init);
    init.setHours(parseInt(item.hora_termino.split(':')[0]));
    init.setMinutes(parseInt(item.hora_termino.split(':')[1]));
  })
  var init = new Date(date);
  appointments.citas[3].jueves.forEach(function (item) {
    createThursdayAppointment(item.nombre, item.hora_inicio, item.hora_termino, init);
    init.setHours(parseInt(item.hora_termino.split(':')[0]));
    init.setMinutes(parseInt(item.hora_termino.split(':')[1]));
  })
  var init = new Date(date);
  appointments.citas[4].viernes.forEach(function (item) {
    createFridayAppointment(item.nombre, item.hora_inicio, item.hora_termino, init);
    init.setHours(parseInt(item.hora_termino.split(':')[0]));
    init.setMinutes(parseInt(item.hora_termino.split(':')[1]));
  })

}

function createMondayAppointment(name, start, end, date) {
  var start_hour = parseInt(start.split(':')[0]);
  var start_min = parseInt(start.split(':')[1]);
  var start_date = new Date();
  start_date.setSeconds(0);
  start_date.setHours(start_hour);
  start_date.setMinutes(start_min);

  var end_hour = parseInt(end.split(':')[0]);
  var end_min = parseInt(end.split(':')[1]);
  var end_date = new Date();
  end_date.setSeconds(0);
  end_date.setHours(end_hour);
  end_date.setMinutes(end_min);


  var lunes = document.getElementById("lunes");

  var top = document.createElement("div");
  top.className = "hour top";
  top.innerText = name;

  var bottom = document.createElement("div");
  bottom.className = "bottom width-date";
  
  while (date < start_date) {
    var empty = document.createElement("div");
    empty.className = "empty-date";
    lunes.appendChild(empty);
    date = addMinutes(date, 30);
  }
  lunes.appendChild(top);

  var start_d = addMinutes(start_date, 30);
  while (start_d <= end_date) {
    var middle = document.createElement("div");
    middle.className = "middle empty-date";
    lunes.appendChild(middle);
    start_d = addMinutes(start_d, 30);
  }

  lunes.appendChild(bottom);
}

function createTuesdayAppointment(name, start, end, date) {
  var start_hour = parseInt(start.split(':')[0]);
  var start_min = parseInt(start.split(':')[1]);
  var start_date = new Date();
  start_date.setSeconds(0);
  start_date.setHours(start_hour);
  start_date.setMinutes(start_min);

  var end_hour = parseInt(end.split(':')[0]);
  var end_min = parseInt(end.split(':')[1]);
  var end_date = new Date();
  end_date.setSeconds(0);
  end_date.setHours(end_hour);
  end_date.setMinutes(end_min);


  var martes = document.getElementById("martes");

  var top = document.createElement("div");
  top.className = "hour top";
  top.innerText = name;

  var bottom = document.createElement("div");
  bottom.className = "bottom width-date";

  while (date < start_date) {
    var empty = document.createElement("div");
    empty.className = "empty-date";
    martes.appendChild(empty);
    date = addMinutes(date, 30);
  }
  martes.appendChild(top);

  var start_d = addMinutes(start_date, 30);
  while (start_d <= end_date) {
    var middle = document.createElement("div");
    middle.className = "middle empty-date";
    martes.appendChild(middle);
    start_d = addMinutes(start_d, 30);
  }

  martes.appendChild(bottom);
}

function createWednesdayAppointment(name, start, end, date) {
  var start_hour = parseInt(start.split(':')[0]);
  var start_min = parseInt(start.split(':')[1]);
  var start_date = new Date();
  start_date.setSeconds(0);
  start_date.setHours(start_hour);
  start_date.setMinutes(start_min);

  var end_hour = parseInt(end.split(':')[0]);
  var end_min = parseInt(end.split(':')[1]);
  var end_date = new Date();
  end_date.setSeconds(0);
  end_date.setHours(end_hour);
  end_date.setMinutes(end_min);


  var miercoles = document.getElementById("miercoles");

  var top = document.createElement("div");
  top.className = "hour top";
  top.innerText = name;

  var bottom = document.createElement("div");
  bottom.className = "bottom width-date";

  while (date < start_date) {
    var empty = document.createElement("div");
    empty.className = "empty-date";
    miercoles.appendChild(empty);
    date = addMinutes(date, 30);
  }
  miercoles.appendChild(top);

  var start_d = addMinutes(start_date, 30);
  while (start_d <= end_date) {
    var middle = document.createElement("div");
    middle.className = "middle empty-date";
    miercoles.appendChild(middle);
    start_d = addMinutes(start_d, 30);
  }

  miercoles.appendChild(bottom);
}

function createThursdayAppointment(name, start, end, date) {
  var start_hour = parseInt(start.split(':')[0]);
  var start_min = parseInt(start.split(':')[1]);
  var start_date = new Date();
  start_date.setSeconds(0);
  start_date.setHours(start_hour);
  start_date.setMinutes(start_min);

  var end_hour = parseInt(end.split(':')[0]);
  var end_min = parseInt(end.split(':')[1]);
  var end_date = new Date();
  end_date.setSeconds(0);
  end_date.setHours(end_hour);
  end_date.setMinutes(end_min);


  var jueves = document.getElementById("jueves");

  var top = document.createElement("div");
  top.className = "hour top";
  top.innerText = name;

  var bottom = document.createElement("div");
  bottom.className = "bottom width-date";

  while (date < start_date) {
    var empty = document.createElement("div");
    empty.className = "empty-date";
    jueves.appendChild(empty);
    date = addMinutes(date, 30);
  }
  jueves.appendChild(top);

  var start_d = addMinutes(start_date, 30);
  while (start_d <= end_date) {
    var middle = document.createElement("div");
    middle.className = "middle empty-date";
    jueves.appendChild(middle);
    start_d = addMinutes(start_d, 30);
  }

  jueves.appendChild(bottom);
}

function createFridayAppointment(name, start, end, date) {
  var start_hour = parseInt(start.split(':')[0]);
  var start_min = parseInt(start.split(':')[1]);
  var start_date = new Date();
  start_date.setSeconds(0);
  start_date.setHours(start_hour);
  start_date.setMinutes(start_min);

  var end_hour = parseInt(end.split(':')[0]);
  var end_min = parseInt(end.split(':')[1]);
  var end_date = new Date();
  end_date.setSeconds(0);
  end_date.setHours(end_hour);
  end_date.setMinutes(end_min);


  var viernes = document.getElementById("viernes");

  var top = document.createElement("div");
  top.className = "hour top";
  top.innerText = name;

  var bottom = document.createElement("div");
  bottom.className = "bottom width-date";

  while (date < start_date) {
    var empty = document.createElement("div");
    empty.className = "empty-date";
    viernes.appendChild(empty);
    date = addMinutes(date, 30);
  }
  viernes.appendChild(top);

  var start_d = addMinutes(start_date, 30);
  while (start_d <= end_date) {
    var middle = document.createElement("div");
    middle.className = "middle empty-date";
    viernes.appendChild(middle);
    start_d = addMinutes(start_d, 30);
  }

  viernes.appendChild(bottom);
}