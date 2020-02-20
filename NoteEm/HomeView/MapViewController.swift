//
//  MapViewController.swift
//  NoteEm
//
//  Created by Intern on 17/02/20.
//  Copyright © 2020 Intern. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }

    private func setupMapView() {
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.74699, longitude: -73.98742), zoomLevel: 9, animated: false)
        mapView.addSubview(mapView)
    }

}
