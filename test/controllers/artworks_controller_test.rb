require 'test_helper'

class ArtworksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artwork = artworks(:one)
  end

  test "should get index" do
    get artworks_url
    assert_response :success
  end

  test "should get new" do
    get new_artwork_url
    assert_response :success
  end

  test "should create artwork" do
    assert_difference('Artwork.count') do
      post artworks_url, params: { artwork: { additionalInfoImage: @artwork.additionalInfoImage, additionalInfoLabel: @artwork.additionalInfoLabel, additionalInfoText: @artwork.additionalInfoText, additionalPdf: @artwork.additionalPdf, amountPaid: @artwork.amountPaid, artType: @artwork.artType, artists_id: @artwork.artists_id, condition: @artwork.condition, currentLocation: @artwork.currentLocation, currentValue: @artwork.currentValue, customers_id: @artwork.customers_id, date: @artwork.date, dateAcquired: @artwork.dateAcquired, description: @artwork.description, dimensions: @artwork.dimensions, frame_dimensions: @artwork.frame_dimensions, image: @artwork.image, medium: @artwork.medium, notes: @artwork.notes, notesImage: @artwork.notesImage, ojbId: @artwork.ojbId, provenance: @artwork.provenance, reviewedBy: @artwork.reviewedBy, reviewedDate: @artwork.reviewedDate, source: @artwork.source, title: @artwork.title } }
    end

    assert_redirected_to artwork_url(Artwork.last)
  end

  test "should show artwork" do
    get artwork_url(@artwork)
    assert_response :success
  end

  test "should get edit" do
    get edit_artwork_url(@artwork)
    assert_response :success
  end

  test "should update artwork" do
    patch artwork_url(@artwork), params: { artwork: { additionalInfoImage: @artwork.additionalInfoImage, additionalInfoLabel: @artwork.additionalInfoLabel, additionalInfoText: @artwork.additionalInfoText, additionalPdf: @artwork.additionalPdf, amountPaid: @artwork.amountPaid, artType: @artwork.artType, artists_id: @artwork.artists_id, condition: @artwork.condition, currentLocation: @artwork.currentLocation, currentValue: @artwork.currentValue, customers_id: @artwork.customers_id, date: @artwork.date, dateAcquired: @artwork.dateAcquired, description: @artwork.description, dimensions: @artwork.dimensions, frame_dimensions: @artwork.frame_dimensions, image: @artwork.image, medium: @artwork.medium, notes: @artwork.notes, notesImage: @artwork.notesImage, ojbId: @artwork.ojbId, provenance: @artwork.provenance, reviewedBy: @artwork.reviewedBy, reviewedDate: @artwork.reviewedDate, source: @artwork.source, title: @artwork.title } }
    assert_redirected_to artwork_url(@artwork)
  end

  test "should destroy artwork" do
    assert_difference('Artwork.count', -1) do
      delete artwork_url(@artwork)
    end

    assert_redirected_to artworks_url
  end
end
