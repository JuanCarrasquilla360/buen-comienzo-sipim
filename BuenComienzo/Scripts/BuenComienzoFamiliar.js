
"use strict";

function Removerscripts(form) {
    $('[id*=scriptsPopup]', form).remove();
}

function ejecutarMetodo(uri, verb, campos, valores, funcSuccess) {
    campos = campos.split(',');

    var params = "{ ";

    if (typeof (valores) != 'object') {
        valores = valores.split(',');
        for (var i = 0; i < campos.length; i++) {
            params += "'" + campos[i] + "':'" + valores[i] + "',";
        }
    }
    else
        params += "'" + campos + "':'" + JSON.stringify(valores) + "' ";

    params = params.substring(0, params.length - 1) + " }";

    $.ajax({
        type: verb,
        url: uri,
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        error: function (jqXHR, textStatus, errorThrown) {
            //alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText);
            alerta('Ha ocurrido un error al tratar de realizar la acción, por favor contacte al administrador del sistema.', 'Error');
        },
        success: funcSuccess
    });
}

function execMethod(uri, verb, _data, funcSuccess) {
    $.ajax({
        type: verb,
        url: uri,
        data: JSON.stringify(_data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        error: function (jqXHR, textStatus, errorThrown) {
            //alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText);
            alerta('Ha ocurrido un error al tratar de realizar la acción, por favor contacte al administrador del sistema.', 'Error');
        },
        success: funcSuccess
    });
}

function execMethod2(uri, verb, _data, funcSuccess) {
    $.ajax({
        type: verb,
        url: uri,
        data: _data,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        error: function (jqXHR, textStatus, errorThrown) {
            //alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText);
            alerta('Ha ocurrido un error al tratar de realizar la acción, por favor contacte al administrador del sistema.', 'Error');
        },
        success: funcSuccess
    });
}

function ejecutarMetodoAsync(uri, verb, campos, valores, funcSuccess) {
    campos = campos.split(',');
    valores = valores.split(',');

    var params = "{ ";
    for (var i = 0; i < campos.length; i++) {
        params += "'" + campos[i] + "':'" + valores[i] + "',";
    }

    params = params.substring(0, params.length - 1) + " }";

    $.ajax({
        type: verb,
        url: uri,
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        error: function (jqXHR, textStatus, errorThrown) {
            //alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText);
            alerta('Ha ocurrido un error al tratar de realizar la acción, por favor contacte al administrador del sistema.', 'Error');
        },
        success: funcSuccess
    });
}


function ejecutarMetodoAsync2(uri, verb, _data, funcSuccess) {

    $.ajax({
        type: verb,
        url: uri,
        data: JSON.stringify(_data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        error: function (jqXHR, textStatus, errorThrown) {
            //alert("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText);
            alerta('Ha ocurrido un error al tratar de realizar la acción, por favor contacte al administrador del sistema.', 'Error');
        },
        success: funcSuccess
    });
}

function alerta(mensaje, tipo) {

    switch (tipo) {
        case 'Error':
            tipo = 'error';
            break;
        case 'Exito':
            tipo = 'success';
            break;
        case 'Advertencia':
            tipo = 'warning';
            break;
    }

    if (typeof (parent.mensaje) === typeof (Function))
        parent.mensaje('', mensaje, tipo);
    else {
        swal.fire('', mensaje, tipo);
    }
}

function confirmar(mensaje, tipo, func) {

    switch (tipo) {
        case 'Error':
            tipo = 'error';
            break;
        case 'Exito':
            tipo = 'success';
            break;
        case 'Advertencia':
            tipo = 'warning';
            break;
    }

    if (typeof (parent.mensaje) === typeof (Function))
        parent.confirmarGral(mensaje, tipo, func);
    else {
        swal.fire({
            title: mensaje,
            text: '',
            icon: tipo,
            showCancelButton: true,
            cancelButtonText: "No",
            confirmButtonText: "Si",
            closeOnConfirm: true
        }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                func();
            }
        });
    }
}

function openPopup(properties, functionSuccess) {

    $.ajax({
        mimeType: 'text/html; charset=utf-8', // ! Need set mimeType only when run from local file
        url: properties.url,
        type: 'GET',
        success: function (data) {

            $('#modalDialog', parent.document).find('.modal').removeClass('modal-success').removeClass('modal-danger').removeClass('modal-warning');
            $('#modalDialog', parent.document).find('.modal-title').html(properties.title);
            $('#modalDialog', parent.document).find('.modal-body').html(data);
            $('#modalDialog', parent.document).find('.modal-footer').html(createButtons(properties.buttons));
            $('#modalDialog', parent.document).find('.modal').fadeIn(200);

            if (properties.width > $(window).width())
                properties.width = $(window).width() * 0.9;

            var widthPopup = (properties.width * 100) / $(window).width();
            var widthSides = (100 - widthPopup) / 2;

            $('#modalDialog', parent.document).find('.modal-dialog').css('width', widthPopup + '%');
            $('#modalDialog', parent.document).find('.modal-rigth').css('width', widthSides + '%');
            $('#modalDialog', parent.document).find('.modal-left').css('width', widthSides + '%');

            if ($('body').hasClass('hold-transition'))
                $('body').css('overflow-y', 'hidden');
            else
                $('body', parent.document).css('overflow-y', 'hidden');

            $(properties.buttons).each(function () {
                $('#modalDialog', parent.document).find('.modal-footer').find('#' + this.name).click(this.click);
            });

            if (functionSuccess != null)
                functionSuccess();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alerta('Ha ocurrido un error al tratar de abrir la página, por favor contacte al administrador del sistema.', 'Error');
        },
        dataType: "html",
        async: false
    });
}

function openPopup2(properties, functionSuccess) {

    $.ajax({
        mimeType: 'text/html; charset=utf-8', // ! Need set mimeType only when run from local file
        url: properties.url,
        type: 'GET',
        success: function (data) {

            $('#modalDialog2', parent.document).find('.modal').removeClass('modal-success').removeClass('modal-danger').removeClass('modal-warning');
            $('#modalDialog2', parent.document).find('.modal-title').html(properties.title);
            $('#modalDialog2', parent.document).find('.modal-body').html(data);
            $('#modalDialog2', parent.document).find('.modal-footer').html(createButtons(properties.buttons));
            $('#modalDialog2', parent.document).find('.modal').fadeIn(200);

            if (properties.width > $(window).width())
                properties.width = $(window).width() * 0.9;

            var widthPopup = (properties.width * 100) / $(window).width();
            var widthSides = (100 - widthPopup) / 2;

            $('#modalDialog2', parent.document).find('.modal-dialog').css('width', widthPopup + '%');
            $('#modalDialog2', parent.document).find('.modal-rigth').css('width', widthSides + '%');
            $('#modalDialog2', parent.document).find('.modal-left').css('width', widthSides + '%');

            if ($('body').hasClass('hold-transition'))
                $('body').css('overflow-y', 'hidden');
            else
                $('body', parent.document).css('overflow-y', 'hidden');

            $(properties.buttons).each(function () {
                $('#modalDialog2', parent.document).find('.modal-footer').find('#' + this.name).click(this.click);
            });

            if (functionSuccess != null)
                functionSuccess();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alerta('Ha ocurrido un error al tratar de abrir la página, por favor contacte al administrador del sistema.', 'Error');
        },
        dataType: "html",
        async: false
    });
}

function openPopup3(properties, functionSuccess) {

    $.ajax({
        mimeType: 'text/html; charset=utf-8', // ! Need set mimeType only when run from local file
        url: properties.url,
        type: 'GET',
        success: function (data) {

            $('#modalDialog3', parent.document).find('.modal').removeClass('modal-success').removeClass('modal-danger').removeClass('modal-warning');
            $('#modalDialog3', parent.document).find('.modal-title').html(properties.title);
            $('#modalDialog3', parent.document).find('.modal-body').html(data);
            $('#modalDialog3', parent.document).find('.modal-footer').html(createButtons(properties.buttons));
            $('#modalDialog3', parent.document).find('.modal').fadeIn(200);

            if (properties.width > $(window).width())
                properties.width = $(window).width() * 0.9;

            var widthPopup = (properties.width * 100) / $(window).width();
            var widthSides = (100 - widthPopup) / 2;

            $('#modalDialog3', parent.document).find('.modal-dialog').css('width', widthPopup + '%');
            $('#modalDialog3', parent.document).find('.modal-rigth').css('width', widthSides + '%');
            $('#modalDialog3', parent.document).find('.modal-left').css('width', widthSides + '%');

            if ($('body').hasClass('hold-transition'))
                $('body').css('overflow-y', 'hidden');
            else
                $('body', parent.document).css('overflow-y', 'hidden');

            $(properties.buttons).each(function () {
                $('#modalDialog3', parent.document).find('.modal-footer').find('#' + this.name).click(this.click);
            });

            if (functionSuccess != null)
                functionSuccess();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alerta('Ha ocurrido un error al tratar de abrir la página, por favor contacte al administrador del sistema.', 'Error');
        },
        dataType: "html",
        async: false
    });
}

function createButtons(buttons) {

    try {
        var htmlBotones = '';
        $(buttons).each(function () {
            htmlBotones += ((htmlBotones == '') ? '' : '&nbsp;') + '<button type="button" class="btn btn-cincopasitos" id="' + this.name + '">' + this.name + '</button>';
        });

        return htmlBotones;
    }
    catch (e) {
        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
    }
}

function CloseModalBox() {

    if ($('body').hasClass('hold-transition'))
        $('body').css('overflow-y', 'auto');
    else
        $('body', parent.document).css('overflow-y', 'auto');

    $('#modalDialog', parent.document).find('.modal').fadeOut(200);
}

//function CloseModalBoxActividadesPrevencion() {

//    if ($('#modalDialog3', parent.document).find('#AdjuntoDiv').is(':visible')) {
//        var divTarjeta = $('#modalDialog3', parent.document).find('#divTarjeta').html().length;
//        console.log('divTarjeta', divTarjeta);
//        if (divTarjeta === 25) {
//            alerta('Recuerde adjuntar la evidencia de la actividad','Advertencia');
//            return;
//        }
//    }

//    if ($('body').hasClass('hold-transition')) {
//        $('body').css('overflow-y', 'auto');
//    }
//    else {
//        $('body', parent.document).css('overflow-y', 'auto');
//    }
//    $('#modalDialog3', parent.document).find('.modal').fadeOut(200);
//}

function CloseModalBox2(salir) {

    if ($('body').hasClass('hold-transition'))
        $('body').css('overflow-y', 'auto');
    else
        $('body', parent.document).css('overflow-y', 'auto');

    $('#modalDialog2', parent.document).find('.modal').fadeOut(200);
    if (salir === "Si") {
        window.parent.location = './Login.aspx';
    }

}

function CloseModalBox3() {

    if ($('body').hasClass('hold-transition'))
        $('body').css('overflow-y', 'auto');
    else
        $('body', parent.document).css('overflow-y', 'auto');

    $('#modalDialog3', parent.document).find('.modal').fadeOut(200);
}

function notificacion(mensaje, tipo, modal) {
    switch (tipo) {
        case 'Error':
            tipo = 'error';
            break;
        case 'Exito':
            tipo = 'success';
            break;
        case 'Advertencia':
            tipo = 'warning';
            break;
    }

    if (typeof (parent.notificacion) === typeof (Function))
        parent.notificacion(mensaje, tipo, modal);
    else {
        noty({
            layout: 'bottomRight',
            text: mensaje,
            type: tipo,
            animation: {
                open: 'animated flipInX', // Animate.css class names
                close: 'animated flipOutX' // Animate.css class names
            },
            timeout: 5000,
            modal: modal,
            maxVisible: 5,
            killer: false
        });
    }
}

//función para editar la dirección
function editarDireccion() {

    var tv1 = ($('#ddlTipoVia').val() == null) ? '' : $('#ddlTipoVia').val();
    var nV1 = ($('#txtVia1').val() == null) ? '' : $('#txtVia1').val();
    var ap1 = ($('#ddlApendice1').val() == null) ? '' : $('#ddlApendice1').val();
    var ca1 = ($('#ddlCardinalidad').val() == null) ? '' : $('#ddlCardinalidad').val();
    var nV2 = ($('#txtVia2').val() == null) ? '' : $('#txtVia2').val();
    var ap2 = ($('#ddlApendice2').val() == null) ? '' : $('#ddlApendice2').val();
    var interior = ($('#txtInt').val() == null) ? '' : $('#txtInt').val();

    //var ca2 = document.forma.cardinalidad2.value;
    var pl = $('#txtPlaca').val();
    var signoNumero = "";
    var guion = "";
    var espacioNv1 = "";
    var espacioCa1 = "";
    var espacioInt = "";
    //var compl = document.forma.complemento.value;

    if (nV2 != "") {
        signoNumero = "#";
    }
    if (pl != "") {
        guion = " - ";
    }

    if (EstaVacio(nV1)) {
        espacioNv1 = "";
    } else {
        espacioNv1 = " ";
    }

    if (EstaVacio(ca1)) {
        espacioCa1 = "";
    } else {
        espacioCa1 = " ";
    }

    if (EstaVacio(interior)) {
        espacioInt = "";
    } else {
        espacioInt = " ";
    }
    var arrayDirreccionEditada = tv1 + espacioNv1 + nV1.toUpperCase() + ap1 + espacioCa1 + ca1 + ((ca1 === "") ? " " : "") + signoNumero + nV2.toUpperCase() + ap2 + guion + pl.toUpperCase() + espacioInt + (interior.toUpperCase() !== '' ? 'Int (' + interior.toUpperCase() + ')' : '');

    var tamanoCadena = parseInt(arrayDirreccionEditada.toString().length);
    $('#lblDireccion').html(arrayDirreccionEditada);
}


function EstaVacio(Dato) {

    for (var i = 0; i < Dato.length; i++) {
        if (Dato.substring(i, i + 1) != " ")
            return (false);
    }
    return (true);
}


function setSelectOptions(selectElement, values, valueKey, textKey, defaultValue) {

    if (typeof (selectElement) == "string") {
        selectElement = $(selectElement);
    }

    selectElement.empty();

    if (typeof (values) == 'object') {
        if (values.length) {
            var type = typeof (values[0]);
            var html = '<option value="">--Seleccione--</option>';

            if (type == 'object') {
                // values is array of hashes
                var optionElement = null;

                $.each(values, function () {
                    html += '<option value="' + this[valueKey] + '">' + this[textKey] + '</option>';
                });

            } else {
                // array of strings
                $.each(values, function () {
                    var value = this.toString();
                    html += '<option value="' + value + '">' + value + '</option>';
                });
            }
            selectElement.append(html);
        }
        else {
            var html = '<option value="">--Seleccione--</option>';
            selectElement.append(html);
        }

        // select the defaultValue is one was passed in
        if (typeof defaultValue != 'undefined') {
            selectElement.children('option[value="' + defaultValue + '"]').attr('selected', 'selected');
        }
    }
    else {
        var html = '<option value="">--Seleccione--</option>';
        selectElement.append(html);
    }
    return false;
}

function ResolveClientURL(url) {
    var root = document.location.toString();
    //Produccion
    /*for (var i = 0; i < (document.location.toString().split('/').length - 4) ; i++) {
        root = root + '../'
    }*/
    //local
    for (var i = 0; i < (document.location.toString().split('/').length - 2); i++) {
        root = root + '../'
    }
    //root = root.substring(0, root.lastIndexOf("/") + 1)
    return root + url;
}

function soloNumeros(e) {
    var key = window.Event ? e.which : e.keyCode
    return (key >= 48 && key <= 57)
}

function keypressNumeric(event) {
    var regex = new RegExp("^[0-9]+$");
    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
    if (!regex.test(key)) {
        event.preventDefault();
        return false;
    }
}

function keypressAlphaNumeric(event) {
    var regex = new RegExp("^[a-zA-Z0-9]+$");
    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
    if (!regex.test(key)) {
        event.preventDefault();
        return false;
    }
}

function keypressDecimal(event, enteros, decimales, separador) {
    var keyDecimal = separador.charCodeAt(0);
    var regex = new RegExp("^[0-9" + separador + "]+$");
    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);

    var parts = event.currentTarget.value.split(separador);

    if (parts.length > 1) {
        if (parts[1].length == decimales) {
            event.preventDefault();
            return false;
        }
    }
    else {
        if (parts[0].length == enteros && event.charCode != keyDecimal) {
            event.preventDefault();
            return false;
        }
    }

    if (!regex.test(key) ||
        (event.charCode == keyDecimal && (event.currentTarget.value.indexOf(separador) > 0)) ||
        (event.charCode == keyDecimal && (event.currentTarget.value == ''))) {
        event.preventDefault();
        return false;
    }
}

function ConfigurarPanel(panel, form, cerrarPaneles) {
    var height = 20;
    $('#' + panel, form).css('min-height', height)
        .on('click', '.collapse-link', function (e) {
            e.preventDefault();

            if (cerrarPaneles) {
                $('.panelInformativo', form).each(function () {
                    if (panel !== $(this).attr('id')) {
                        $(this).find("div.boxAcordion").each(function () {
                            if ($(this).find('i.fa-chevron-up').length > 0) {
                                $(this).find('div.boxAcordion-content').slideToggle('fast');
                                $(this).find('i:eq(1)').toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
                            }
                        });
                    }
                });
            }

            var box = $(this).closest('div.boxAcordion', form);
            var button = $(this).find('i', form);
            var content = box.find('div.boxAcordion-content', form);

            content.slideToggle('fast');
            button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
            setTimeout(function () {
                box.resize();
                box.find('[id^=map-]').resize();
            }, 50);
        });
}

// funcion para validar el correo
function ValidateEmail(email) {
    //var email = $(email).val();
    var caract = new RegExp(/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/);

    if (email != '') {
        if (caract.test(email) == false)
            return false;
        else
            return true;
    }
    else
        return true;
}

