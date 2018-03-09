<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .martb0{    margin-bottom: 0;   margin-top: 3px;}
</style>
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/plugins/iCheck/all.css">

<!-- iCheck 1.0.1 -->
<script src="${pageContext.request.contextPath}/adminlte/plugins/iCheck/icheck.min.js"></script>

<script>
    // 查询参数
    search_keyWord = null;
    cat1 = null;
    cat2 = null;
    cat3 = null;

    $(function () {
        bootstrapValidatorInit();
        baseTableInit();
        searchActionInit();
        checkInit();
        selectListInit("cat1_select", "类别一级");
        selectListInit("cat2_select", "类别二级");
        selectListInit("cat3_select", "类别三级");

        addAction();
        editAction();
        deleteAction();
        importAction();
        exportAction()
    })

    function selectListInit(select_name, keyWord) {
        $("select[name="+select_name+"]").empty(); //清空
        $.ajax({
            url: 'goodsCategoryManage/getCategoryNameList',
            type: "get",
            data: {
                keyWord: keyWord
            },
            cache: false,
            error: function () {
            },
            success: function (response) {
                var modelList = response.rows;
                if (modelList && modelList.length != 0) {
                    for (var i = 0; i < modelList.length; i++) {
                        var option = "<option value=\"" + modelList[i] + "\"";
                        if (0 == i) {
                            option += " selected=\"selected\" "; //默认选中
                        }
                        option += ">" + modelList[i] + "</option>"; //动态添加数据
                        $("select[name="+select_name+"]").append(option);
                    }
                }
            }
        });
    }

    // 添加供应商模态框数据校验
    function bootstrapValidatorInit() {
        $("#add_goodsInfo_form,#edit_goodsInfo_form").bootstrapValidator({
            message: 'This is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            excluded: [':disabled'],
            fields: {
                customer_name: {
                    validators: {
                        notEmpty: {
                            message: '名称不能为空'
                        }
                    }
                },
                customer_tel: {
                    validators: {
                        notEmpty: {
                            message: '电话不能为空'
                        }
                    }
                },
                customer_email: {
                    validators: {
                        notEmpty: {
                            message: 'E-mail不能为空'
                        },
                        regexp: {
                            regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                            message: 'E-mail的格式不正确'
                        }
                    }
                },
                customer_address: {
                    validators: {
                        notEmpty: {
                            message: '地址不能为空'
                        }
                    }
                },
                customer_person: {
                    validators: {
                        notEmpty: {
                            message: '负责人不能为空'
                        }
                    }
                }
            }
        })
    }

    function changeDateFormat(value) {
        if (value != null) {
            var date = new Date(value);
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
            var D = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            return Y + M + D;
        }
    }

    // 编辑商品
    function editAction() {
        $('#edit_modal_submit').click(
            function () {
                $('#edit_goodsInfo_form').data('bootstrapValidator').validate();
                if (!$('#edit_goodsInfo_form').data('bootstrapValidator').isValid()) {
                    return;
                }

                var status = 0;
                var val = $('input:radio[name="edit_radio"]:checked').val();
                if (val == '1') {
                    status = 1;
                } else {
                    status = 0;
                }

                var index = $('select[name="cat1_select"]')[0].selectedIndex;
                var cat1 = $('select[name="cat1_select"]').val(); // 选中值
                index = $('select[name="cat2_select"]')[0].selectedIndex;
                var cat2 = $('select[name="cat2_select"]').val(); // 选中值
                index = $('select[name="cat3_select"]')[0].selectedIndex;
                var cat3 = $('select[name="cat3_select"]').val(); // 选中值
                var person = '${sessionScope.userInfo.userName}';

                var data = {
                    id: selectID,
                    name: $('#edit_name').val(),
                    cat1: cat1,
                    cat2: cat2,
                    cat3: cat3,
                    alias: $('#edit_alias').val(),
                    status: status,
                    mperson: person,
                    param1: $('#edit_attr_param1').val(),
                    param2: $('#edit_attr_param2').val(),
                    param3: $('#edit_attr_param3').val(),
                    param4: $('#edit_attr_param4').val(),
                    param5: $('#edit_attr_param5').val(),
                    param6: $('#edit_attr_param6').val(),
                    param7: $('#edit_attr_param7').val(),
                    param8: $('#edit_attr_param8').val(),
                    param9: $('#edit_attr_param9').val(),
                    param10: $('#edit_attr_param10').val(),
                    param11: $('#edit_attr_param11').val(),
                    param12: $('#edit_attr_param12').val(),
                    param13: $('#edit_attr_param13').val(),
                    param14: $('#edit_attr_param14').val(),
                    param15: $('#edit_attr_param15').val(),
                    param16: $('#edit_attr_param16').val()
                }

                // ajax
                $.ajax({
                    type: "POST",
                    url: 'goodsAttrInfoManage/updateGoodsAttrInfo',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    success: function (response) {
                        $('#edit_modal').modal("hide");
                        var type;
                        var msg;
                        var append = '';
                        if (response.result == "success") {
                            type = "success";
                            msg = "商品更新成功";
                        } else if (resposne == "error") {
                            type = "error";
                            msg = "商品更新失败"
                        }
                        showMsg(type, msg, append);
                        tableRefresh();
                    },
                    error: function (xhr, textStatus, errorThrow) {
                        $('#edit_modal').modal("hide");
                        // handler error
                        handleAjaxError(xhr.status);
                    }
                });
            });
    }

    // 刪除商品
    function deleteAction() {
        $('#delete_confirm').click(function () {
            var data = {
                "ID": selectID
            }

            // ajax
            $.ajax({
                type: "GET",
                url: "goodsAttrInfoManage/deleteGoodsAttrInfo",
                dataType: "json",
                contentType: "application/json",
                data: data,
                success: function (response) {
                    $('#deleteWarning_modal').modal("hide");
                    var type;
                    var msg;
                    var append = '';
                    if (response.result == "success") {
                        type = "success";
                        msg = "商品删除成功";
                    } else {
                        type = "error";
                        msg = "商品删除失败";
                    }
                    showMsg(type, msg, append);
                    tableRefresh();
                }, error: function (xhr, textStatus, errorThrow) {
                    $('#deleteWarning_modal').modal("hide");
                    // handler error
                    handleAjaxError(xhr.status);
                }
            })

            $('#deleteWarning_modal').modal('hide');
        })
    }

    // 添加商品
    function addAction() {
        $('#add_btn').click(function () {
            $('#add_modal').modal("show");
        });

        $('#add_modal_submit').click(function () {
            var status = 0;
            var val = $('input:radio[name="add_radio"]:checked').val();
            if (val == '启用') {
                status = 1;
            } else {
                status = 0;
            }

            var index = $('select[name="cat1_select"]')[0].selectedIndex;
            var cat1 = $('select[name="cat1_select"]').val(); // 选中值
            index = $('select[name="cat2_select"]')[0].selectedIndex;
            var cat2 = $('select[name="cat2_select"]').val(); // 选中值
            index = $('select[name="cat3_select"]')[0].selectedIndex;
            var cat3 = $('select[name="cat3_select"]').val(); // 选中值
            var person = '${sessionScope.userInfo.userName}';

            var data = {
                name: $('#add_name').val(),
                cat1: cat1,
                cat2: cat2,
                cat3: cat3,
                alias: $('#add_alias').val(),
                status: status,
                mperson: person,
                cperson: person,
                param1: $('#add_attr_param1').val(),
                param2: $('#add_attr_param2').val(),
                param3: $('#add_attr_param3').val(),
                param4: $('#add_attr_param4').val(),
                param5: $('#add_attr_param5').val(),
                param6: $('#add_attr_param6').val(),
                param7: $('#add_attr_param7').val(),
                param8: $('#add_attr_param8').val(),
                param9: $('#add_attr_param9').val(),
                param10: $('#add_attr_param10').val(),
                param11: $('#add_attr_param11').val(),
                param12: $('#add_attr_param12').val(),
                param13: $('#add_attr_param13').val(),
                param14: $('#add_attr_param14').val(),
                param15: $('#add_attr_param15').val(),
                param16: $('#add_attr_param16').val()

            }
            // ajax
            $.ajax({
                type: "POST",
                url: "goodsAttrInfoManage/addGoodsAttrInfo",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function (response) {
                    $('#add_modal').modal("hide");
                    var msg;
                    var type;
                    var append = '';
                    if (response.result == "success") {
                        type = "success";
                        msg = "商品添加成功";
                    } else if (response.result == "error") {
                        type = "error";
                        msg = "商品添加失败";
                    }
                    showMsg(type, msg, append);
                    tableRefresh();

                    // reset
                    $('#edit_name').val("");
                    $('#type_select').val("");
                    $('#goods_size').val("");
                    $('#goods_value').val("");
                    $('#add_goodsInfo_form').bootstrapValidator("resetForm", true);
                },
                error: function (xhr, textStatus, errorThrow) {
                    $('#add_modal').modal("hide");
                    // handler error
                    handleAjaxError(xhr.status);
                }
            })
        })
    }

    function checkInit() {
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
        //Red color scheme for iCheck
        $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
            checkboxClass: 'icheckbox_minimal-red',
            radioClass: 'iradio_minimal-red'
        });
        //Flat red color scheme for iCheck
        $('input[type="checkbox"].square-green, input[type="radio"].square-green').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });

    }

    // 表格初始化
    function baseTableInit() {
        $('#goodsInfoTable').bootstrapTable({
            columns: [{
                field: 'id',
                title: '序号'
            }, {
                field: 'code',
                title: '编码'
            }, {
                field: 'name',
                title: '名称'
            }, {
                field: 'alias',
                title: '别名'
            }, {
                field: 'cat1',
                title: '类别一级'
            }, {
                field: 'cat2',
                title: '类别二级'
            }, {
                field: 'cat3',
                title: '类别三级'
            }, {
                field: 'status',
                title: '状态',
                formatter: function (value, row, index) {
                    if (value == 1) {
                        return '启用';
                    }
                    if (value == 0) {
                        return '禁用';
                    }
                }
            }, {
                field: 'ctime',
                title: '建档日期',
                formatter: function (value, row, index) {
                    return changeDateFormat(value)
                }
            }, {
                field: 'cperson',
                title: '修改人'
            }, {
                field: 'mtime',
                title: '修改日期',
                formatter: function (value, row, index) {
                    return changeDateFormat(value)
                }
            }, {
                field: 'mperson',
                title: '修改人'
            }, {
                field: 'operation',
                title: '操作',
                formatter: function (value, row, index) {
                    var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
                    var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                    var fun = '';
                    return s + ' ' + d;
                },
                events: {
                    // 操作列中编辑按钮的动作
                    'click .edit': function (e, value,
                                             row, index) {
                        selectID = row.id;
                        rowEditOperation(row);
                    },
                    'click .delete': function (e,
                                               value, row, index) {
                        selectID = row.id;
                        $('#deleteWarning_modal').modal(
                            'show');
                    }
                }
            }],
            url: 'goodsAttrInfoManage/getGoodsAttrInfoList',
            onLoadError: function (status) {
                handleAjaxError(status);
            },
            method: 'GET',
            queryParams: queryParams,
            sidePagination: "server",
            dataType: 'json',
            pagination: true,
            pageNumber: 1,
            pageSize: 5,
            pageList: [5, 10, 25, 50, 100],
            clickToSelect: true
        });
    }

    // 表格刷新
    function tableRefresh() {
        $('#goodsInfoTable').bootstrapTable('refresh', {
            query: {}
        });
    }

    // 分页查询参数
    function queryParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            keyWord: search_keyWord,
            cat1:cat1,
            cat2:cat2,
            cat3:cat3,
            searchType: 0
        }
        return temp;
    }

    // 行编辑操作
    function rowEditOperation(row) {
        $('#edit_modal').modal("show");

        // load info
        $('#edit_goodsInfo_form').bootstrapValidator("resetForm", true);
        $('#edit_name').val(row.name);
        $('#edit_alias').val(row.alias);
        $("select[name=cat1_select]").val(row.cat1);
        $("select[name=cat2_select]").val(row.cat2);
        $("select[name=cat3_select]").val(row.cat3);

        if (1 == row.status) {
            $($("input[name='edit_radio']").eq(0)).iCheck('check');
        } else {
            $($("input[name='edit_radio']").eq(1)).iCheck('check');
        }

        $('#edit_attr_param1').val(row.param1);
        $('#edit_attr_param2').val(row.param2);
        $('#edit_attr_param3').val(row.param3);
        $('#edit_attr_param4').val(row.param4);
        $('#edit_attr_param5').val(row.param5);
        $('#edit_attr_param6').val(row.param6);
        $('#edit_attr_param7').val(row.param7);
        $('#edit_attr_param8').val(row.param8);
        $('#edit_attr_param9').val(row.param9);
        $('#edit_attr_param10').val(row.param10);
        $('#edit_attr_param11').val(row.param11);
        $('#edit_attr_param12').val(row.param12);
        $('#edit_attr_param13').val(row.param13);
        $('#edit_attr_param14').val(row.param14);
        $('#edit_attr_param15').val(row.param15);
        $('#edit_attr_param16').val(row.param16);
    }

    // 查询操作
    function searchActionInit() {
        $('#search_btn').click(function () {
            search_keyWord = $('#key_word').val();
            var index = $('select[name="cat1_select"]')[0].selectedIndex;
            cat1 = $('select[name="cat1_select"]').val(); // 选中值
            index = $('select[name="cat2_select"]')[0].selectedIndex;
            cat2 = $('select[name="cat2_select"]').val(); // 选中值
            index = $('select[name="cat3_select"]')[0].selectedIndex;
            cat3 = $('select[name="cat3_select"]').val(); // 选中值

            tableRefresh();
        })
    }

    var import_step = 1;
    var import_start = 1;
    var import_end = 3;

    // 导入
    function importAction() {
        $('#import_btn').click(function () {
            $('#import_modal').modal("show");
        });

        $('#previous').click(function () {
            if (import_step > import_start) {
                var preID = "step" + (import_step - 1)
                var nowID = "step" + import_step;

                $('#' + nowID).addClass("hide");
                $('#' + preID).removeClass("hide");
                import_step--;
            }
        })

        $('#next').click(function () {
            if (import_step < import_end) {
                var nowID = "step" + import_step;
                var nextID = "step" + (import_step + 1);

                $('#' + nowID).addClass("hide");
                $('#' + nextID).removeClass("hide");
                import_step++;
            }
        })

        $('#file').on("change", function () {
            $('#previous').addClass("hide");
            $('#next').addClass("hide");
            $('#submit').removeClass("hide");
        })

        $('#submit').click(function () {
            var nowID = "step" + import_end;
            $('#' + nowID).addClass("hide");
            $('#uploading').removeClass("hide");

            // next
            $('#confirm').removeClass("hide");
            $('#submit').addClass("hide");

            // ajax
            $.ajaxFileUpload({
                url: "goodsAttrInfoManage/importGoodsAttrInfo",
                secureuri: false,
                dataType: 'json',
                fileElementId: "file",
                success: function (data, status) {
                    var total = 0;
                    var available = 0;
                    var msg1 = "导入成功";
                    var msg2 = "导入失败";
                    var info;

                    $('#import_progress_bar').addClass("hide");
                    if (data.result == "success") {
                        total = data.total;
                        available = data.available;
                        info = msg1;
                        $('#import_success').removeClass('hide');
                    } else {
                        info = msg2
                        $('#import_error').removeClass('hide');
                    }
                    info = info + ",总条数：" + total + ",有效条数:" + available;
                    $('#import_result').removeClass('hide');
                    $('#import_info').text(info);
                    $('#confirm').removeClass('disabled');
                }, error: function (data, status) {
                    // handle error
                    handlerAjaxError(status);
                }
            })
        })

        $('#confirm').click(function () {
            // modal dissmiss
            importModalReset();
        })
    }

    // 导出
    function exportAction() {
        $('#export_btn').click(function () {
            $('#export_modal').modal("show");
        })

        $('#export_download').click(function () {
            var data = {
                searchType: 0,
                keyWord: search_keyWord
            }
            var url = "goodsAttrInfoManage/exportGoodsAttrInfo?" + $.param(data)
            window.open(url, '_blank');
            $('#export_modal').modal("hide");
        })
    }

    // 导入模态框重置
    function importModalReset() {
        var i;
        for (i = import_start; i <= import_end; i++) {
            var step = "step" + i;
            $('#' + step).removeClass("hide")
        }
        for (i = import_start; i <= import_end; i++) {
            var step = "step" + i;
            $('#' + step).addClass("hide")
        }
        $('#step' + import_start).removeClass("hide");

        $('#import_progress_bar').removeClass("hide");
        $('#import_result').removeClass("hide");
        $('#import_success').removeClass('hide');
        $('#import_error').removeClass('hide');
        $('#import_progress_bar').addClass("hide");
        $('#import_result').addClass("hide");
        $('#import_success').addClass('hide');
        $('#import_error').addClass('hide');
        $('#import_info').text("");
        $('#file').val("");

        $('#previous').removeClass("hide");
        $('#next').removeClass("hide");
        $('#submit').removeClass("hide");
        $('#confirm').removeClass("hide");
        $('#submit').addClass("hide");
        $('#confirm').addClass("hide");


        $('#file').on("change", function () {
            $('#previous').addClass("hide");
            $('#next').addClass("hide");
            $('#submit').removeClass("hide");
        })

        import_step = 1;
    }

</script>

<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">商品</h3>
    </div>
    <div class="box-body">
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs pull-right">
                <li class="active"><a href="#tab_1" data-toggle="tab">基本操作</a></li>
                <li class="pull-left header"><i class="fa fa-th"></i></li>
            </ul>
            <div class="tab-content" style="position: relative;z-index: 100;">
                <div class="tab-pane active" id="tab_1">
                    <div class="row margin">
                        <div class="form-inline">
                            <label class="form-label">查询条件：</label>

                            <select name="cat1_select" class="form-control"></select>
                            <select name="cat2_select" class="form-control"></select>
                            <select name="cat3_select" class="form-control"></select>

                            <button class="btn btn-primary" id="search_btn">
                                <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                            </button>
                            <button class="btn btn-success" id="add_btn">
                                <span class="glyphicon glyphicon-plus"></span> <span>新增</span>
                            </button>
                            <button class="btn btn-success" id="import_btn">
                                <span class="glyphicon glyphicon-import"></span> <span>批量导入</span>
                            </button>
                            <button class="btn btn-success" id="export_btn">
                                <span class="glyphicon glyphicon-import"></span> <span>批量导出</span>
                            </button>
                        </div>
                    </div>
                    <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
            </div>
            <!-- nav-tabs-custom -->
        </div>
    </div>
    <div class="box-footer">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-bordered table-hover" id="goodsInfoTable"></table>
            </div>
        </div>
    </div>
</div>

<!-- 导入模态框 -->
<div class="modal fade" id="import_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabelimport" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabel">导入</h4>
            </div>
            <div class="modal-body">
                <div id="step1">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10">
                            <div>
                                <h4>点击下面的下载按钮，下载电子表格</h4>
                            </div>
                            <div style="margin-top: 30px; margin-buttom: 15px">
                                <a class="btn btn-info"
                                   href="commons/fileSource/download/goodsInfoInfo.xlsx"
                                   target="_blank"> <span class="glyphicon glyphicon-download"></span>
                                    <span>下载</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="step2" class="hide">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10">
                            <div>
                                <h4>请按照电子表格中指定的格式填写需要添加的一个或多个</h4>
                            </div>
                            <div class="alert alert-info"
                                 style="margin-top: 10px; margin-buttom: 30px">
                                <p>注意：表格中各个列均不能为空，若存在未填写的项，则该条将不能成功导入</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="step3" class="hide">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-8 col-sm-10">
                            <div>
                                <div>
                                    <h4>请点击下面上传文件按钮，上传填写好的电子表格</h4>
                                </div>
                                <div style="margin-top: 30px; margin-buttom: 15px">
									<span class="btn btn-info btn-file"> <span> <span
                                            class="glyphicon glyphicon-upload"></span> <span>上传文件</span>
									</span>
									<form id="import_file_upload"><input type="file" id="file" name="file"></form>
									</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hide" id="uploading">
                    <div class="row" style="margin-top: 15px" id="import_progress_bar">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10"
                             style="margin-top: 30px; margin-bottom: 30px">
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     role="progreessbar" aria-valuenow="60" aria-valuemin="0"
                                     aria-valuemax="100" style="width: 100%;">
                                    <span class="sr-only">请稍后...</span>
                                </div>
                            </div>
                            <!--
                            <div style="text-align: center">
                                <h4 id="import_info"></h4>
                            </div>
                             -->
                        </div>
                        <div class="col-md-1 col-sm-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-4"></div>
                        <div class="col-md-4 col-sm-4">
                            <div id="import_result" class="hide">
                                <div id="import_success" class="hide" style="text-align: center;">
                                    <img src="media/icons/success-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                                <div id="import_error" class="hide" style="text-align: center;">
                                    <img src="media/icons/error-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4"></div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-3"></div>
                        <div class="col-md-6" style="text-align: center;">
                            <h4 id="import_info"></h4>
                        </div>
                        <div class="col-md-3"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn ben-default" type="button" id="previous">
                    <span>上一步</span>
                </button>
                <button class="btn btn-success" type="button" id="next">
                    <span>下一步</span>
                </button>
                <button class="btn btn-success hide" type="button" id="submit">
                    <span>&nbsp;&nbsp;&nbsp;提交&nbsp;&nbsp;&nbsp;</span>
                </button>
                <button class="btn btn-success hide disabled" type="button"
                        id="confirm" data-dismiss="modal">
                    <span>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 导出模态框 -->
<div class="modal fade" id="export_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabelexport">导出</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认导出</h3>
                        <p>(注意：请确定要导出的，导出的内容为当前列表的搜索结果)</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="export_download">
                    <span>确认下载</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 添加商品模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabelAdd">添加</h4>
            </div>
            <div class="modal-body">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#activity" data-toggle="tab">基本信息</a></li>
                        <li><a href="#attribute" data-toggle="tab">属性信息</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="active tab-pane" id="activity">
                            <div class="row">
                                <div class="col-md-1 col-sm-1"></div>
                                <div class="col-md-8 col-sm-8">
                                    <form class="form-horizontal" role="form" id="goodsInfo_form" name="goodsInfo_form"
                                          style="margin-top: 25px">
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>名称：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" class="form-control" id="add_name"
                                                       name="add_name" placeholder="名称">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>别名：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" class="form-control" id="add_alias"
                                                       name="add_alias" placeholder="别名">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别一级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat1_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别二级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat2_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别三级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat3_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>状态：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <div class="row margin">
                                                    <%--<div class="form-inline">--%>
                                                    <label class="pull-left">
                                                        <input type="radio" name="add_radio" class="square-green"
                                                               value="启用"
                                                               checked>
                                                        启用
                                                    </label>
                                                    <label class="pull-right">
                                                        <input type="radio" name="add_radio" class="square-green"
                                                               value="禁用">
                                                        禁用
                                                    </label>
                                                    </div>
                                                </div>
                                            </div>
                                        <%--</div>--%>
                                    </form>
                                </div>
                                <div class="col-md-1 col-sm-1"></div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="attribute">
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性1：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param1" name="add_attr_param1"
                                                   placeholder="属性1">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性2：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param2" name="add_attr_param2"
                                                   placeholder="属性2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性3：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param3" name="add_attr_param3"
                                                   placeholder="属性3">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性4：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param4" name="add_attr_param4"
                                                   placeholder="属性4">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性5：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param5" name="add_attr_param5"
                                                   placeholder="属性5">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性6：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param6" name="add_attr_param6"
                                                   placeholder="属性6">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性7：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param7" name="add_attr_param7"
                                                   placeholder="属性7">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性8：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param8" name="add_attr_param8"
                                                   placeholder="属性8">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性9：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param9" name="add_attr_param9"
                                                   placeholder="属性9">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性10：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param10" name="add_attr_param10"
                                                   placeholder="属性10">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性11：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param11" name="add_attr_param11"
                                                   placeholder="属性11">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性12：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param12" name="add_attr_param12"
                                                   placeholder="属性12">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性13：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param13" name="add_attr_param13"
                                                   placeholder="属性13">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性14：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param14" name="add_attr_param14"
                                                   placeholder="属性14">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性15：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param15" name="add_attr_param15"
                                                   placeholder="属性15">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性16：</span></label>
                                            <input type="text" class="form-control" id="add_attr_param16" name="add_attr_param16"
                                                   placeholder="属性16">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                    </div>
                </div>
                <!-- /.tab-content -->
            </div>
            <div class="modal-footer">
            <button class="btn btn-default" type="button" data-dismiss="modal">
                <span>取消</span>
            </button>
            <button class="btn btn-success" type="button" id="add_modal_submit">
                <span>提交</span>
            </button>
        </div>
        </div>
    </div>
</div>

<!-- 删除提示模态框 -->
<div class="modal modal-danger" id="deleteWarning_modal" table-index="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabelDel">警告</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认删除该条</h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-danger" type="button" id="delete_confirm">
                    <span>确认删除</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑商品模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabelEdit">商品</h4>
            </div>
            <div class="modal-body">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#edit_activity" data-toggle="tab">基本信息</a></li>
                        <li><a href="#edit_attribute" data-toggle="tab">属性信息</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="active tab-pane" id="edit_activity">
                            <div class="row">
                                <div class="col-md-1 col-sm-1"></div>
                                <div class="col-md-8 col-sm-8">
                                    <form class="form-horizontal" role="form" id="edit_goodsInfo_form" name="edit_goodsInfo_form"
                                          style="margin-top: 25px">
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>名称：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" class="form-control" id="edit_name"
                                                       name="edit_name" placeholder="名称">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>别名：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <input type="text" class="form-control" id="edit_alias"
                                                       name="edit_alias" placeholder="别名">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别一级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat1_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别二级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat2_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>类别三级：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <select class="form-control" name="cat3_select">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-4 col-sm-4"> <span>状态：</span>
                                            </label>
                                            <div class="col-md-8 col-sm-8">
                                                <div class="row margin">
                                                    <label class="pull-left">
                                                        <input type="radio" name="add_radio" class="square-green"
                                                               value="启用"
                                                               checked>
                                                        启用
                                                    </label>
                                                    <label class="pull-right">
                                                        <input type="radio" name="add_radio" class="square-green"
                                                               value="禁用">
                                                        禁用
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-md-1 col-sm-1"></div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="edit_attribute">
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性1：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param1" name="edit_attr_param1"
                                                   placeholder="属性1">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性2：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param2" name="edit_attr_param2"
                                                   placeholder="属性2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性3：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param3" name="edit_attr_param3"
                                                   placeholder="属性3">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性4：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param4" name="edit_attr_param4"
                                                   placeholder="属性4">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性5：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param5" name="edit_attr_param5"
                                                   placeholder="属性5">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性6：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param6" name="edit_attr_param6"
                                                   placeholder="属性6">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性7：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param7" name="edit_attr_param7"
                                                   placeholder="属性7">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性8：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param8" name="edit_attr_param8"
                                                   placeholder="属性8">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性9：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param9" name="edit_attr_param9"
                                                   placeholder="属性9">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性10：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param10" name="edit_attr_param10"
                                                   placeholder="属性10">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性11：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param11" name="edit_attr_param11"
                                                   placeholder="属性11">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性12：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param12" name="edit_attr_param12"
                                                   placeholder="属性12">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性13：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param13" name="edit_attr_param13"
                                                   placeholder="属性13">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性14：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param14" name="edit_attr_param14"
                                                   placeholder="属性14">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row margin">
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-left">
                                        <div class="form-inline">
                                            <label> <span>属性15：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param15" name="edit_attr_param15"
                                                   placeholder="属性15">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="pull-right">
                                        <div class="form-inline">
                                            <label> <span>属性16：</span></label>
                                            <input type="text" class="form-control" id="edit_attr_param16" name="edit_attr_param16"
                                                   placeholder="属性16">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="edit_modal_submit">
                    <span>确认更改</span>
                </button>
            </div>
        </div>
    </div>
</div>