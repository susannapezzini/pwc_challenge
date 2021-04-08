import createChart from './create_chart.js'
import updateChart from './update_chart.js'

const compareChart = () => {
  const elements = [...document.getElementsByClassName("select-subproduct")];
  const compareBtn = document.getElementById("compare-btn")
  const myProduct = elements[0];
  const otherProduct = elements[1];
  console.log({elements})
  console.log({otherProduct})
  console.log({myProduct})

  const ctx = document.getElementById('product-chart');
  const compareChart = createChart(ctx, myProduct, 0, otherProduct, 0)
  if (elements) {
    compareBtn.addEventListener('click', () => {
      const option = myProduct.options.selectedIndex;
      console.log({option});
      const myPrice = myProduct.attributes.id.ownerElement[option+1].dataset.subPrice;
      console.log({myPrice});
      // const myBankName = myProduct.value.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') || 'bob';
      // console.log(myBankName)
      // const otherPrice = +otherProduct.dataset.productPrice || 0;
      // const otherBankName = otherProduct.value.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') || 'bob';
      // const labels = [myBankName, otherBankName]
      // console.log(otherBankName)
      // updateChart(compareChart, labels, [2.76, 4.26])
    })
  }
}

export { compareChart };