//
//  TubiMoviesTests.swift
//  TubiMoviesTests
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import XCTest
import Combine
@testable import TubiMovies

class TubiMoviesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testMovieList() throws {
        let expectation = self.expectation(description: "Get movies list")
        var cancellables: Set<AnyCancellable> = []
        let viewModel = MovieViewModel()
        
        viewModel.fetchMovies()
        viewModel.$movies.dropFirst().receive(on: DispatchQueue.main).sink { movies in
            expectation.fulfill()
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertTrue(viewModel.movies.count > 0)
    }
    
    func testMovieDetails() throws {
        let expectation = self.expectation(description: "Get movie details for given movie id")
        var cancellables: Set<AnyCancellable> = []
        let viewModel = MovieDetailsViewModel()
        
        viewModel.fetchMovieDetails(id: "369854")
        viewModel.$movieDetails.dropFirst().receive(on: DispatchQueue.main).sink { movieDetails in
            expectation.fulfill()
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertEqual(viewModel.movieDetails?.id, "369854")
    }

}
