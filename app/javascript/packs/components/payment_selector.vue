<template>
  <div class="field">
	<label for="order_pay_type"> Pay Type </label>
    <select id="order_pay_type" name="order[pay_type]" @change="onchange" v-model='key'>  
		<option value=""> Select a payment method </option>
		<option value="Check"> Check </option>
		<option value="Credit card"> Credit card </option>
		<option value="Purchase order"> Purchase order </option>
    </select>
	<component v-bind:is="selectedPayType"></component>
  </div>
</template>

<script>
import NoPayType from './NoPayType.vue'
import CreditCartPayType from './CreditCardPayType.vue'
import CheckPayType from './CheckPayType.vue'
import PurchaseOrderPayType from './PurchaseOrderPayType.vue'


export default {
  components: {
  	NoPayType,
  	CreditCartPayType,
  	CheckPayType,
  	PurchaseOrderPayType
  },
  data: function () {
    return {
		key: ""
    }
  },
  mounted: function(){
	this.key = ""
  },
  computed: {
	selectedPayType: function(){
	  switch(this.key){
		case 'Credit card':
		  return CreditCartPayType;
        case 'Check':
          return CheckPayType;
        case 'Purchase order':
          return PurchaseOrderPayType;
        default:
          return NoPayType;
	  }
	}
  },
  methods:{
  	onchange: function(){
		console.log(this.key)
    }
  }
}
</script>
