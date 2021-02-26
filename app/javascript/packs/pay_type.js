import Vue from 'vue'
import PaymentSelector from './components/payment_selector.vue'

document.addEventListener('turbolinks:load', () => {
	const selector = new Vue({
		render: h => h(PaymentSelector)
	}).$mount('#pay-type-component')
});
