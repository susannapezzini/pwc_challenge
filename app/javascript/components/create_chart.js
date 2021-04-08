const createChart = (ctx, labels, data) => {
      const colors = ['rgba(116,25,16,0.5)', 'rgba(170,36,23,0.5)', 'rgba(224,48,30,0.5)', 'rgba(232,97,83,0.5)', 'rgba(247,200,196,0.5)']
      const borderColors = ['rgb(116,25,16)', 'rgb(170,36,23)', 'rgb(224,48,30)', 'rgb(232,97,83)', 'rgb(247,200,196)']
      let compareChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Total price',
          data: data,
          backgroundColor: colors,
          borderColor: borderColors,
          borderWidth: 1
        }]
      },
      options: {
        title: {
            display: true,
            text: 'Product Comparison',
            font: {
              size: 50
            }
        },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        },
      }
    });
  return (compareChart);
}

export default createChart