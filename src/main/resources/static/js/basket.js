    // --------------- 주문으로 데이터 전달 부분 
/*     function collectSelectedItems() {
        const selectedItems = [];
        document.querySelectorAll('.item-select:checked').forEach(checkbox => {
            const parentItem = checkbox.closest('.item'); // 부모 요소 찾기
            //const productCode = checkbox.getAttribute('data-index'); // 데이터 인덱스 사용
            const productCode = parentItem.querySelector('.hidden-product-code').textContent;
            //const productCode = document.getElementById(`hidden-product-code-${index}`);
            
            
            const productName = parentItem.querySelector('.item-details p').textContent;
            const orderQuantity = parentItem.querySelector('.quantity-control span').textContent;
            //const productPrice = parentItem.querySelector('.original-price') ? parentItem.querySelector('.original-price').textContent.replace('원', '') : 0;
            const productPrice = parentItem.querySelector('.hidden-product-price').textContent;
            //const productPrice = document.getElementById(`hidden-product-price-${index}`);
            
            
            const orderPrice = parentItem.querySelector('.price-container span').textContent.replace('원', '');
            const shippingPrice = parentItem.querySelector('.shipping-fee p').textContent.replace('원', '');

            selectedItems.push({
                productCode,
                //productCode:parseInt(productCode),	// int값으로 전달
                productName,
                orderQuantity: parseInt(orderQuantity),
                productPrice: parseFloat(productPrice),  // 수량 고려한 총 제품 가격 (할인율 없이)
                orderPrice: parseFloat(orderPrice), // 수량 고려한 총 제품 가격 (할인율 있이)
                shippingPrice: parseFloat(shippingPrice),
                orderCode:null
            });
        });
        return selectedItems;
    	}
    	
    	function sendOrderData() {
    	    const orderItems = collectSelectedItems();
    	    if (orderItems.length === 0) {
    	        alert('선택된 상품이 없습니다.');
    	        return;
    	    }
    	    
    	    const orderTotalElement = document.querySelector('.order-total');
    	    const totalOrderPrice = parseFloat(orderTotalElement.textContent.replace('원', '').replace(/,/g, ''));

    	    // 주문 상세 정보를 구성
    	    const orderDetailRequest = {
    	        products: orderItems.map(item => ({
    	            productCode: item.productCode,
    	            orderQuantity: item.orderQuantity,
    	            productPrice: item.productPrice,
    	            orderPrice: item.orderPrice,
    	            orderCode: item.orderCode
    	        })),
    	        shippingPrice: 3000,
    	        totalOrderPrice: totalOrderPrice
    	    };
    	    
    	    // 데이터 정합성 테스트
    	    // 클라이언트 콘솔 로그 출력
    	    console.log('Sending order detail request:', orderDetailRequest);
    	    // products 배열의 내용을 각각 출력
    	    orderDetailRequest.products.forEach((product, index) => {
    	        console.log(`Product ${index + 1}:`, product);
    	    });

    	    // 서버로 주문 데이터 전송
    	    fetch('/app/order/createOrderAndProducts', {
    	        method: 'POST',
    	        headers: {
    	            'Content-Type': 'application/json'
    	        },
    	        body: JSON.stringify(orderDetailRequest)
    	    })
    	    .then(response => {
    	        if (response.ok) {
    	            window.location.href = '/app/order/orderpage'; // 주문 확인 페이지로 이동
    	        } else {
    	            return response.json().then(errorData => {
    	                console.error('Error:', errorData); // 서버에서 반환된 오류 처리
    	            });
    	        }
    	    })
    	    .catch(error => console.error('Error:', error)); // 네트워크 오류 처리
    	} */