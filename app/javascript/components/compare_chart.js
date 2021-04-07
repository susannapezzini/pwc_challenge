import createChart from './create_chart.js'
import updateChart from './update_chart.js'

const compareChart = () => {
  const elements = [...document.getElementsByClassName("select-bank")];
  const compareBtn = document.getElementById("compare-btn")
  const myProduct = elements[0];
  const otherProduct = elements[1];
  console.log(elements)
  console.log(otherProduct)
  console.log(myProduct)

  const ctx = document.getElementById('compare-chart');
  const compareChart = createChart(ctx, 'Bank 1', 0, 'Bank 2', 0)
  if (elements) {
    compareBtn.addEventListener('click', () => {
      const myPrice = +myProduct.dataset.bankPrice || 0;
      console.log(myPrice)
      const myBankName = myProduct.value.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') || 'bob';
      console.log(myBankName)
      const otherPrice = +otherProduct.dataset.productPrice || 0;
      const otherBankName = otherProduct.value.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') || 'bob';
      const labels = [myBankName, otherBankName]
      console.log(otherBankName)
      updateChart(compareChart, labels, [2.76, 4.26])
    })
  }
}

export { compareChart };