import createChart from './create_chart.js'

const compareChart = () => {
  const myProduct = document.querySelector('.my-product');
  const otherProduct = document.querySelector('.other-product');

  if (myProduct && otherProduct) {
    const compareBtn = document.querySelector('#compare-btn');
    compareBtn.addEventListener('click', () => {
      const myPrice = +myProduct.dataset.productPrice || 0;
      const myBankName = myProduct.dataset.bankName;
      const otherPrice = +otherProduct.dataset.productPrice || 0;
      const otherBankName = otherProduct.dataset.bankName;
      const ctx = document.getElementById('compareChart');
      createChart(ctx, myBankName, myPrice, otherBankName, otherPrice)
    })
  }
}

export { compareChart };