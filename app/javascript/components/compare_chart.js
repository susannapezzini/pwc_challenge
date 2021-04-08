import createChart from './create_chart.js'
import updateChart from './update_chart.js'

const compareChart = () => {
  const elements = [...document.getElementsByClassName("select-subproduct")];
  const compareBtn = document.getElementById("compare-btn")
  // const myProduct = elements[0];
  // const product1 = elements[1];
  // const product2 = elements[2];
  // console.log({product1})
  // console.log({myProduct})

  let data = []
  let labels = []

  const getLabels = (array) => {
    labels = []
    array.forEach(e => {
      const option = e.options.selectedIndex;
      e = e.attributes.id.ownerElement[option].dataset.bank;
      labels.push(e);
      return labels;
    })
  }
  
  const getData = (array) => {
    data = []
    array.forEach(e => {
      const option = e.options.selectedIndex;
      e = e.attributes.id.ownerElement[option].dataset.subPrice;
      data.push(e);
      return data;
    })

  }

  
  const ctx = document.getElementById('product-chart');
  if (elements) {
    getLabels(elements);
    getData(elements);
    const compareChart = createChart(ctx, labels, data)
    console.log({elements})
    compareBtn.addEventListener('click', () => {
      getLabels(elements);
      console.log({labels});
      getData(elements);
      console.log({data});
      updateChart(compareChart, labels, data)
    })
  }
}

export { compareChart };