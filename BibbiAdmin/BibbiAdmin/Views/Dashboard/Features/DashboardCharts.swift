//
//  DashboardChart.swift
//  BibbiAdmin
//
//  Created by 김건우 on 4/29/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct DashboardCharts {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var values: [DailyValueResponse]?
        var rawSelectedDate: Date?
        var selectedDate: Date?
        var selectedValue: DailyValueResponse?
    }
    
    // MARK: - Dependencies
    @Dependency(\.calendar) var calendar
    
    // MARK: - Action
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.rawSelectedDate):
                state.selectedDate = checkVaildSelection(
                    on: state.rawSelectedDate,
                    values: state.values
                )
                state.selectedValue = checkVaildValue(
                    on: state.selectedDate,
                    values: state.values
                )
                return .none
                
            case .binding:
                return .none
            }
        }
        
    }
}

extension DashboardCharts {
    
    private func endOfDate(_ date: Date) -> Date {
        calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
    private func checkVaildSelection(on rawSelctedDate: Date?, values: [DailyValueResponse]?) -> Date? {
        // 선택한 날짜(X축)가 오늘~다음 날에 포함되는 Values가 있는지 확인
        if let date = rawSelctedDate {
            return values?.first(where: { response in
                let endOfDate = self.endOfDate(response.date)

                return (response.date...endOfDate).contains(date)
            })?.date
        }
    
        return nil
    }
    
    private func checkVaildValue(on selectedDate: Date?, values: [DailyValueResponse]?) -> DailyValueResponse? {
        guard let selectedDate = selectedDate, let values = values,
              let value = values.first(where: { value in
            value.date.isEqual(with: selectedDate)
        }) else {
            return nil
        }

        return value
    }
    
}
