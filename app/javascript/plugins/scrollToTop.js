const scrollToTop = () => {
  const button = document.getElementById('scrollTop');
  if (!button) {
    return;
  }
  button.addEventListener('click', event => {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
    console.log('hello');
  });
}

export { scrollToTop };