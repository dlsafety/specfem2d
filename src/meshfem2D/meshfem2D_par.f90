!========================================================================
!
!                   S P E C F E M 2 D  Version 7 . 0
!                   --------------------------------
!
!     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
!                        Princeton University, USA
!                and CNRS / University of Marseille, France
!                 (there are currently many more authors!)
! (c) Princeton University and CNRS / University of Marseille, April 2014
!
! This software is a computer program whose purpose is to solve
! the two-dimensional viscoelastic anisotropic or poroelastic wave equation
! using a spectral-element method (SEM).
!
! This program is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 2 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along
! with this program; if not, write to the Free Software Foundation, Inc.,
! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
!
! The full text of the license is available in file "LICENSE".
!
!========================================================================

  module parameter_file_par

  ! note: we use this module definition only to be able to allocate
  !          arrays for receiverlines and materials in this subroutine rather than in the main
  !          routine in meshfem2D.F90

  ! note 2: the filename ending is .F90 to have pre-compilation with pragmas
  !            (like #ifndef USE_MPI) working properly

  use shared_input_parameters

  implicit none

  !--------------------------------------------------------------
  ! variables for computation
  !--------------------------------------------------------------

  ! material file for changing the model parameter for inner mesh or updating the
  ! the material for an existed mesh
  ! (obsolete in Par_file now...)
  !logical :: assign_external_model, READ_EXTERNAL_SEP_FILE

  ! for absorbing boundary condition
  logical :: any_abs

  ! for Bielak
  logical :: add_Bielak_conditions

  ! to store density and velocity model
  integer, dimension(:),allocatable :: num_material
  integer, dimension(:),allocatable :: icodemat

  ! acoustic/elastic/anisotropic
  double precision, dimension(:),allocatable :: rho_s,cp,cs, &
    aniso3,aniso4,aniso5,aniso6,aniso7,aniso8,aniso9,aniso10,aniso11,aniso12,QKappa,Qmu

  ! poroelastic
  double precision, dimension(:),allocatable :: rho_f,phi,tortuosity,permxx,permxz,&
       permzz,kappa_s,kappa_f,kappa_fr,eta_f,mu_fr

  ! for interpolated snapshot
  logical :: plot_lowerleft_corner_only

  end module parameter_file_par

!
!---------------------------------------------------------------------------------------
!

  module source_file_par

  use constants,only: MAX_STRING_LEN

  implicit none

  ! source type parameters
  integer, dimension(:),pointer ::  source_type,time_function_type
  ! location
  double precision, dimension(:),pointer :: xs,zs
  ! moment tensor
  double precision, dimension(:),pointer :: Mxx,Mzz,Mxz
  ! source parameters
  double precision, dimension(:),pointer :: f0_source,tshift_src,anglesource,factor,burst_band_width
  ! flag for fixation to surface
  logical, dimension(:),allocatable ::  source_surf
  ! File name can't exceed MAX_STRING_LEN characters
  character(len=MAX_STRING_LEN), dimension(:),allocatable :: name_of_source_file

  end module source_file_par

!
!---------------------------------------------------------------------------------------
!

  module decompose_par

  implicit none

  ! variables used for storing info about the mesh and partitions
  integer, dimension(:), allocatable  :: my_interfaces
  integer, dimension(:), allocatable  :: my_nb_interfaces

  end module decompose_par

!
!---------------------------------------------------------------------------------------
!

  module part_unstruct_par

! This module contains subroutines related to unstructured meshes and partitioning of the
! corresponding graphs.

  implicit none

  integer :: nelmnts
  integer, dimension(:), allocatable  :: elmnts
  integer, dimension(:), allocatable  :: elmnts_bis
  integer, dimension(:), allocatable  :: vwgt
  integer, dimension(:), allocatable  :: glob2loc_elmnts
  integer, dimension(:), allocatable  :: part

  integer :: nb_edges
  integer, dimension(:), allocatable  :: adjwgt

  integer, dimension(:), allocatable  :: xadj_g
  integer, dimension(:), allocatable  :: adjncy_g

  integer :: nnodes
  double precision, dimension(:,:), allocatable  :: nodes_coords
  integer, dimension(:), allocatable  :: nnodes_elmnts
  integer, dimension(:), allocatable  :: nodes_elmnts
  integer, dimension(:), allocatable  :: glob2loc_nodes_nparts
  integer, dimension(:), allocatable  :: glob2loc_nodes_parts
  integer, dimension(:), allocatable  :: glob2loc_nodes

  ! interface data
  integer :: ninterfaces
  integer, dimension(:), allocatable  :: tab_size_interfaces, tab_interfaces

  integer :: nelem_acoustic_surface
  integer, dimension(:,:), allocatable  :: acoustic_surface
  integer :: nelem_acoustic_surface_loc

  integer :: nelem_on_the_axis
  integer, dimension(:), allocatable  :: ispec_of_axial_elements
  integer, dimension(:), allocatable  :: inode1_axial_elements, inode2_axial_elements
  integer :: nelem_on_the_axis_loc

  integer :: nelemabs
  integer, dimension(:,:), allocatable  :: abs_surface
  logical, dimension(:,:), allocatable  :: abs_surface_char
  integer, dimension(:), allocatable  :: abs_surface_merge,abs_surface_type
  integer :: nelemabs_loc

  integer :: nelemabs_merge
  integer, dimension(:), allocatable  :: ibegin_edge1,iend_edge1,ibegin_edge3,iend_edge3, &
       ibegin_edge4,iend_edge4,ibegin_edge2,iend_edge2

  ! for acoustic/elastic coupled elements
  integer :: nedges_coupled
  integer, dimension(:,:), allocatable  :: edges_coupled

  ! for acoustic/poroelastic coupled elements
  integer :: nedges_acporo_coupled
  integer, dimension(:,:), allocatable  :: edges_acporo_coupled

  ! for poroelastic/elastic coupled elements
  integer :: nedges_elporo_coupled
  integer, dimension(:,:), allocatable  :: edges_elporo_coupled

  ! for acoustic forcing elements
  integer :: nelemacforcing
  integer, dimension(:,:), allocatable :: acforcing_surface
  logical, dimension(:,:), allocatable  :: acforcing_surface_char
  integer, dimension(:), allocatable  :: acforcing_surface_merge,acforcing_surface_type
  integer :: nelemacforcing_loc

  integer :: nelemacforcing_merge
  integer, dimension(:), allocatable  :: ibegin_edge1_acforcing,iend_edge1_acforcing, &
       ibegin_edge3_acforcing,iend_edge3_acforcing,ibegin_edge4_acforcing,iend_edge4_acforcing, &
       ibegin_edge2_acforcing,iend_edge2_acforcing

  ! vertical layers
  integer :: number_of_layers
  integer, dimension(:), allocatable :: nz_layer

  ! variables used for tangential detection
  integer ::  nnodes_tangential_curve
  double precision, dimension(:,:), allocatable  :: nodes_tangential_curve

  ! interface file data
  integer :: max_npoints_interface,number_of_interfaces
  integer :: nx,nz,nxread,nzread

  ! coordinates of the grid points of the mesh
  double precision, dimension(:,:), allocatable :: grid_point_x,grid_point_z

  integer :: npoints_interface_top
  double precision, dimension(:), allocatable :: xinterface_top,zinterface_top,coefs_interface_top

  end module part_unstruct_par
