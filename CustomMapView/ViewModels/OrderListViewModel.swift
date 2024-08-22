import SwiftUI

class OrderListViewModel: ObservableObject {
    @Published var orderList: OrderList
    @Published var selectedStop: Stop?
    
    init(orderList: OrderList) {
        self.orderList = orderList
    }
    
    func selectStop(_ stop: Stop) {
        selectedStop = stop
    }
}
