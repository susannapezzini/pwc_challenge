const createChart = (ctx, product1, price1, product2, price2) => {
      let compareChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: [product1, product2],
        datasets: [{
          // label: 'Products comparison',
          data: [price1, price2],
          backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)'],
          borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)'],
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