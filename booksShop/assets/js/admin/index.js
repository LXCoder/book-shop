$(document).ready(function (e) {
    
    updateWeekOrderCount();
    updateMonthIncome();
});

function updateWeekOrderCount() {
    $.ajax({
        url: "index.aspx?method=updateWeekOrderCount",
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                jsonData = JSON.parse(result.data);
                var $dashChartBarsCnt = jQuery('.js-chartjs-bars')[0].getContext('2d');
                var $dashChartBarsData = {
                    labels: [jsonData.date[0], jsonData.date[1], jsonData.date[2], jsonData.date[3], jsonData.date[4], jsonData.date[5], jsonData.date[6]],
                    datasets: [
                        {
                            label: '等待付款',
                            borderWidth: 1,
                            borderColor: 'rgba(0,0,0,0)',
                            backgroundColor: 'rgba(51,202,185,0.5)',
                            hoverBackgroundColor: "rgba(51,202,185,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: [jsonData.one[0], jsonData.one[1], jsonData.one[2], jsonData.one[3], jsonData.one[4], jsonData.one[5], jsonData.one[6]]
                        },
                        {
                            label: '准备发货',
                            borderWidth: 1,
                            borderColor: 'rgba(0,0,0,0)',
                            backgroundColor: 'rgba(249,104,104,0.5)',
                            hoverBackgroundColor: "rgba(249,104,104,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: [jsonData.two[0], jsonData.two[1], jsonData.two[2], jsonData.two[3], jsonData.two[4], jsonData.two[5], jsonData.two[6]]
                        },
                        {
                            label: '等待付款',
                            borderWidth: 1,
                            borderColor: 'rgba(0,0,0,0)',
                            backgroundColor: 'rgba(146,109,222,0.5)',
                            hoverBackgroundColor: "rgba(146,109,222,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: [jsonData.three[0], jsonData.three[1], jsonData.three[2], jsonData.three[3], jsonData.three[4], jsonData.three[5], jsonData.three[6]]
                        },
                        {
                            label: '交易完成',
                            borderWidth: 1,
                            borderColor: 'rgba(0,0,0,0)',
                            backgroundColor: 'rgba(21,195,119,0.5)',
                            hoverBackgroundColor: "rgba(21,195,119,0.7)",
                            hoverBorderColor: "rgba(0,0,0,0)",
                            data: [jsonData.four[0], jsonData.four[1], jsonData.four[2], jsonData.four[3], jsonData.four[4], jsonData.four[5], jsonData.four[6]]
                        }
                    ]
                };
                new Chart($dashChartBarsCnt, {
                    type: 'bar',
                    data: $dashChartBarsData
                });
            }
        }
    });
}

function updateMonthIncome() {
    $.ajax({
        url: "index.aspx?method=updateMonthIncome",
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                var jsonData = JSON.parse(result.data);
                var $dashChartLinesCnt = jQuery('.js-chartjs-lines')[0].getContext('2d');
                var $dashChartLinesData = {
                    labels: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                    datasets: [
                        {
                            label: '月收入',
                            data: [jsonData.income[0], jsonData.income[1], jsonData.income[2], jsonData.income[3], jsonData.income[4], jsonData.income[5], jsonData.income[6], jsonData.income[7], jsonData.income[8], jsonData.income[9], jsonData.income[10], jsonData.income[11]],
                            borderColor: '#358ed7',
                            backgroundColor: 'rgba(53, 142, 215, 0.175)',
                            borderWidth: 1,
                            fill: false,
                            lineTension: 0.5
                        }
                    ]
                };

                var myLineChart = new Chart($dashChartLinesCnt, {
                    type: 'line',
                    data: $dashChartLinesData,
                });
            }
        }
    });
}

function editStockValue(bid, stock) {
    $("#stock").val(stock);
 
    $("#stockBtn").click(function () {
        var stock = $("#stock").val();
        $.ajax({
            url: "bookAdmin.aspx?method=editStock",
            data: { "bid": bid, "stock": stock },
            type: "GET",
            dataType: "json",
            success: function (result) {
                if (result.status) {

                    messageSuccess("修改成功！", "");
                    $('#stockNumber' + bid).text(stock);
                    

                    $('#stockModal').modal('hide');
                } else {
                    //失败请求操作
                    messageWarming(result.msg, "");
                }
            }
        });
    })
}